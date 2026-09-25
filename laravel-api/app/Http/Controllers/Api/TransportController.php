<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\TransportAssignment;
use App\Models\TransportRoute;
use App\Models\TransportStop;
use App\Models\TransportVehicle;
use App\Models\User;
use App\Services\NotificationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class TransportController extends Controller
{
    // Student routes
    public function myRoute(Request $request)
    {
        $assignment = TransportAssignment::with(['route.stops', 'route.vehicles'])
            ->where('student_user_id', $request->user()->id)
            ->where('is_active', true)
            ->first();

        return response()->json($assignment);
    }

    // Parent routes
    public function childTransport(Request $request, int $studentId)
    {
        $isMyChild = $request->user()->children()->where('users.id', $studentId)->exists();
        if (! $isMyChild) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $assignment = TransportAssignment::with(['route.stops', 'route.vehicles'])
            ->where('student_user_id', $studentId)
            ->where('is_active', true)
            ->first();

        return response()->json($assignment);
    }

    // Admin routes
    public function routes(Request $request)
    {
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'name' => 'required|string',
                'description' => 'nullable|string',
                'departure_time' => 'required|date_format:H:i',
                'return_time' => 'required|date_format:H:i',
                'fee' => 'required|numeric|money|min:0',
                'capacity' => 'required|integer|min:1',
            ]);
            if (! empty($data['route_id'])) {
                abort_unless(TransportRoute::query()->whereKey($data['route_id'])->exists(), 422, 'The route belongs to another school.');
            }
            if (! empty($data['driver_id'])) {
                abort_unless(User::query()->whereKey($data['driver_id'])
                    ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $request->attributes->get('school_id')))
                    ->exists(), 422, 'The driver belongs to another school.');
            }

            $route = TransportRoute::create($data);

            return response()->json($route, 201);
        }

        return response()->json(TransportRoute::with(['stops', 'vehicles'])->get());
    }

    public function vehicles(Request $request)
    {
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'registration_number' => ['required', 'string', Rule::unique('transport_vehicles')->where('school_id', $request->attributes->get('school_id'))],
                'model' => 'nullable|string',
                'type' => 'required|string',
                'capacity' => 'required|integer|min:1',
                'route_id' => 'nullable|exists:transport_routes,id',
                'driver_id' => 'nullable|exists:users,id',
            ]);
            abort_unless(TransportRoute::query()->whereKey($data['route_id'])->exists(), 422, 'The route belongs to another school.');

            $vehicle = TransportVehicle::create($data);

            return response()->json($vehicle, 201);
        }

        return response()->json(TransportVehicle::with(['route', 'driver'])->get());
    }

    public function stops(Request $request)
    {
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'route_id' => 'required|exists:transport_routes,id',
                'name' => 'required|string',
                'address' => 'required|string',
                'latitude' => 'nullable|numeric',
                'longitude' => 'nullable|numeric',
                'pickup_time' => 'required|date_format:H:i',
                'dropoff_time' => 'required|date_format:H:i',
                'sequence_number' => 'required|integer|min:0',
            ]);

            $stop = TransportStop::create($data);

            return response()->json($stop, 201);
        }

        $query = TransportStop::with('route');

        if ($routeId = $request->query('route_id')) {
            $query->where('route_id', $routeId);
        }

        return response()->json($query->orderBy('sequence_number')->get());
    }

    public function assignStudent(Request $request)
    {
        $data = $request->validate([
            'student_user_id' => 'required|exists:users,id',
            'route_id' => 'required|exists:transport_routes,id',
            'pickup_stop_id' => 'nullable|exists:transport_stops,id',
            'dropoff_stop_id' => 'nullable|exists:transport_stops,id',
            'start_date' => 'required|date',
            'end_date' => 'nullable|date|after:start_date',
        ]);

        $schoolId = (int) $request->attributes->get('school_id');
        abort_unless(User::query()->whereKey($data['student_user_id'])->where('role', 'student')
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $schoolId))
            ->exists(), 422, 'The student belongs to another school.');

        $assignment = DB::transaction(function () use ($data) {
            $route = TransportRoute::query()->lockForUpdate()->findOrFail($data['route_id']);
            abort_if($route->availableSeats() <= 0, 409, 'Route is at full capacity.');

            foreach (['pickup_stop_id', 'dropoff_stop_id'] as $stopKey) {
                if (! empty($data[$stopKey])) {
                    abort_unless(
                        TransportStop::query()->whereKey($data[$stopKey])->where('route_id', $route->id)->exists(),
                        422,
                        'Pickup and drop-off stops must belong to the selected route.',
                    );
                }
            }

            TransportAssignment::where('student_user_id', $data['student_user_id'])
                ->where('is_active', true)
                ->update(['is_active' => false, 'end_date' => now()]);
            $assignment = TransportAssignment::create($data);

            DB::afterCommit(fn () => NotificationService::sendToParents(
                $data['student_user_id'],
                'transport_assigned',
                [
                    'route_name' => $route->name,
                    'pickup_time' => $route->departure_time,
                    'dropoff_time' => $route->return_time,
                ],
            ));

            return $assignment;
        });

        return response()->json($assignment, 201);
    }

    public function allAssignments(Request $request)
    {
        $query = TransportAssignment::with(['student', 'route', 'pickupStop', 'dropoffStop']);

        if ($request->query('active_only')) {
            $query->where('is_active', true);
        }

        if ($routeId = $request->query('route_id')) {
            $query->where('route_id', $routeId);
        }

        return response()->json($query->paginate($this->perPage($request, 20)));
    }
}
