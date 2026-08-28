<?php

namespace App\Console\Commands;

use Dedoc\Scramble\Generator;
use Dedoc\Scramble\Scramble;
use Illuminate\Console\Command;
use Illuminate\Routing\Route;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Route as RouteFacade;
use Illuminate\Support\Str;
use stdClass;
use Symfony\Component\Yaml\Yaml;

class GenerateOpenApi extends Command
{
    protected $signature = 'openapi:generate';

    protected $description = 'Generate the canonical OpenAPI 3.1 contract';

    public function handle(Generator $generator): int
    {
        $result = $generator->generate(Scramble::getGeneratorConfig(Scramble::DEFAULT_API));
        $specification = $result->spec();

        if (($specification['openapi'] ?? null) !== '3.1.0') {
            $this->error('Scramble did not generate an OpenAPI 3.1.0 document.');

            return self::FAILURE;
        }

        // Keep the committed contract environment-neutral. Scramble otherwise
        // expands this server from APP_URL, which would make the artifact drift
        // between developer machines and could expose an internal hostname.
        $specification['servers'] = [[
            'url' => '/api',
            'description' => 'Relative API base path',
        ]];

        $this->normalizeDocument($specification);

        $missingOperations = $this->missingOperations($specification);

        if ($missingOperations !== []) {
            $this->error('Scramble omitted API operations:');
            foreach ($missingOperations as $operation) {
                $this->line(" - {$operation}");
            }

            return self::FAILURE;
        }

        $path = base_path('openapi.yaml');
        $yaml = Yaml::dump(
            $specification,
            30,
            2,
            Yaml::DUMP_MULTI_LINE_LITERAL_BLOCK | Yaml::DUMP_EMPTY_ARRAY_AS_SEQUENCE | Yaml::DUMP_OBJECT_AS_MAP,
        );
        File::put($path, $yaml);

        $operationCount = collect($specification['paths'] ?? [])
            ->sum(fn (array $pathItem): int => count(array_intersect_key($pathItem, array_flip($this->openApiMethods()))));

        $this->info("OpenAPI 3.1 document generated at {$path}.");
        $this->line(count($specification['paths'] ?? [])." paths, {$operationCount} operations, 0 omitted API operations.");

        if ($result->diagnostics()->isNotEmpty()) {
            $this->warn($result->diagnostics()->count().' Scramble analysis warnings; run `php artisan scramble:analyze -v` for details.');
        }

        return self::SUCCESS;
    }

    /** @param array<string, mixed> $specification */
    private function normalizeDocument(array &$specification): void
    {
        foreach ($specification['paths'] as $path => &$pathItem) {
            foreach ($this->openApiMethods() as $method) {
                if (! isset($pathItem[$method]) || isset($pathItem[$method]['summary'])) {
                    continue;
                }

                $operationId = $pathItem[$method]['operationId'] ?? null;
                $pathItem[$method]['summary'] = $operationId
                    ? Str::headline(str_replace('.', ' ', $operationId))
                    : strtoupper($method).' '.$path;
            }
        }
        unset($pathItem);

        $this->normalizeSchemaKeywords($specification);
    }

    private function normalizeSchemaKeywords(mixed &$node, ?string $parentKey = null): void
    {
        if (! is_array($node)) {
            return;
        }

        if (array_key_exists('additionalItems', $node)) {
            if ($node['additionalItems'] === false && array_key_exists('prefixItems', $node)) {
                $node['items'] = false;
            }
            unset($node['additionalItems']);
        }

        foreach ($node as $key => &$value) {
            if ($value === null && ($parentKey === 'properties' || in_array($key, ['items', 'additionalProperties', 'schema'], true))) {
                $value = new stdClass;
                continue;
            }

            $this->normalizeSchemaKeywords($value, is_string($key) ? $key : $parentKey);
        }
        unset($value);
    }

    /**
     * @param  array<string, mixed>  $specification
     * @return list<string>
     */
    private function missingOperations(array $specification): array
    {
        $documented = [];

        foreach (($specification['paths'] ?? []) as $path => $pathItem) {
            foreach ($this->openApiMethods() as $method) {
                if (array_key_exists($method, $pathItem)) {
                    $documented[] = strtoupper($method).' '.$this->normalizePathParameters($path);
                }
            }
        }

        $documented = array_flip($documented);
        $missing = [];

        foreach (RouteFacade::getRoutes() as $route) {
            if (! $this->isApiRoute($route)) {
                continue;
            }

            $path = $route->uri() === 'api'
                ? '/'
                : '/'.substr($route->uri(), strlen('api/'));

            foreach ($route->methods() as $method) {
                if (! in_array(strtolower($method), $this->openApiMethods(), true)) {
                    continue;
                }

                $operation = strtoupper($method).' '.$this->normalizePathParameters($path);
                if (! isset($documented[$operation])) {
                    $missing[] = $operation;
                }
            }
        }

        sort($missing);

        return array_values(array_unique($missing));
    }

    private function isApiRoute(Route $route): bool
    {
        return $route->uri() === 'api' || str_starts_with($route->uri(), 'api/');
    }

    private function normalizePathParameters(string $path): string
    {
        return preg_replace('/\{[^}]+}/', '{}', $path) ?? $path;
    }

    /** @return list<string> */
    private function openApiMethods(): array
    {
        // Laravel implicitly adds HEAD to every GET route. OpenAPI represents
        // that behavior through GET, so only explicitly describable operations
        // participate in route coverage.
        return ['get', 'put', 'post', 'delete', 'options', 'patch', 'trace'];
    }
}
