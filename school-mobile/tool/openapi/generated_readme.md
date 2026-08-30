# Generated API client

Everything in this directory is machine output, generated from the committed
OpenAPI contract at `laravel-api/openapi.yaml`.

**These files are never hand-edited.** Any manual change here is overwritten by
the next regeneration and is rejected by the drift job in
`.github/workflows/mobile.yml`. To change what lands here, change the contract
(in `laravel-api/`) or the generator options in
`school-mobile/tool/openapi/generate.dart`, then regenerate.

## Regenerating

From the `school-mobile/` package root:

```sh
dart run tool/openapi/generate.dart
```

That single command resolves dependencies, runs OpenAPI Generator (pinned in
`tool/openapi/openapi_generator_config.json`), replaces this directory with
fresh output, and runs `build_runner` to emit the `*.g.dart` built_value
serialization code. Output is reproducible: regenerating without a contract change produces
byte-identical files.

## Layout

| Path | Contents |
| --- | --- |
| `model/` | built_value request/response models, one serializer each |
| `api/` | One class per tag, each method wrapping a Dio call |
| `auth/` | Dio interceptors for the contract's security schemes |
| `api.dart` | `SchoolMobile` client — see base URL note below |
| `school_mobile.dart` | Barrel re-exporting every model and API |
| `serializers.dart` | Registry of every model serializer |

## Base URL

The base URL is injected at construction and is never hardcoded here:

```dart
final client = SchoolMobile(basePathOverride: apiBaseUrl);
```

The `SchoolMobile.basePath` constant is the relative path `/api`, taken from the
contract's `servers` entry. It carries no host, scheme, or credentials — supply
the full origin through `basePathOverride` (or pass a preconfigured `Dio`).

## Analysis

`lib/generated/` is excluded from the analyzer in `analysis_options.yaml`;
generated code is not held to the lint rules that hand-written code is. It is
still fully type-checked whenever it is compiled, which `flutter test` does via
`test/generated_client_test.dart`.
