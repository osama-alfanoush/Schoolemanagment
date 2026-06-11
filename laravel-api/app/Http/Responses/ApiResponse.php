<?php

declare(strict_types=1);

namespace App\Http\Responses;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;
use Illuminate\Pagination\LengthAwarePaginator;

class ApiResponse
{
    /**
     * Success with data.
     */
    public static function success(mixed $data, int $status = 200): JsonResponse
    {
        return response()->json(['data' => $data], $status);
    }

    /**
     * Success with paginated data.
     */
    public static function paginate(LengthAwarePaginator $paginator): JsonResponse
    {
        return response()->json([
            'data' => $paginator->items(),
            'meta' => [
                'current_page' => $paginator->currentPage(),
                'last_page' => $paginator->lastPage(),
                'per_page' => $paginator->perPage(),
                'total' => $paginator->total(),
            ],
        ]);
    }

    /**
     * Created response.
     */
    public static function created(mixed $data): JsonResponse
    {
        return response()->json(['data' => $data], 201);
    }

    /**
     * Error response.
     */
    public static function error(string $message, int $status = 400, array $errors = []): JsonResponse
    {
        $response = ['message' => $message];

        if (! empty($errors)) {
            $response['errors'] = $errors;
        }

        return response()->json($response, $status);
    }

    /**
     * Not found response.
     */
    public static function notFound(string $message = 'Not found'): JsonResponse
    {
        return self::error($message, 404);
    }

    /**
     * Validation error response.
     */
    public static function validationError(array $errors): JsonResponse
    {
        return self::error('Validation failed', 422, $errors);
    }

    /**
     * Deleted response (no content).
     */
    public static function deleted(): Response
    {
        return response()->noContent();
    }

    /**
     * Success with summary data.
     */
    public static function withSummary(mixed $data, array $summary): JsonResponse
    {
        return response()->json([
            'data' => $data,
            'summary' => $summary,
        ]);
    }
}