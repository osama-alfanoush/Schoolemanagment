<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\TransportAssignment;
use App\Models\TransportRoute;
use App\Models\TransportStop;
use App\Models\TransportVehicle;
use App\Services\NotificationService;
use Illuminate\Http\Request;

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
        if (!$isMyChild) {
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
                'fee' => 'required|numeric|min:0',
                'capacity' => 'required|integer|min:1',
            ]);

            $route = TransportRoute::create($data);

            return response()->json($route, 201);
        }

        return response()->json(TransportRoute::with(['stops', 'vehicles'])->get());
    }

    public function vehicles(Request $request)
    {
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'registration_number' => 'required|string|unique:transport_vehicles',
                'model' => 'nullable|string',
                'type' => 'required|string',
                'capacity' => 'required|integer|min:1',
                'route_id' => 'nullable|exists:transport_routes,id',
                'driver_id' => 'nullable|exists:users,id',
            ]);

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

        $route = TransportRoute::findOrFail($data['route_id']);

        if ($route->availableSeats() <= 0) {
            return response()->json(['message' => 'Route is at full capacity'], 400);
        }

        // Deactivate any existing assignment for this student
        TransportAssignment::where('student_user_id', $data['student_user_id'])
            ->where('is_active', true)
            ->update(['is_active' => false, 'end_date' => now()]);

        $assignment = TransportAssignment::create($data);

        // Notify parents
        NotificationService::sendToParents(
            $data['student_user_id'],
            'transport_assigned',
            [
                'route_name' => $route->name,
                'pickup_time' => $route->departure_time,
                'dropoff_time' => $route->return_time,
            ]
        );

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

        return response()->json($query->paginate($request->query('per_page', 20)));
    }
}
