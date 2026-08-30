// Regenerates the Dart API client under lib/generated/ from the committed
// OpenAPI contract at ../laravel-api/openapi.yaml.
//
// Run from the school-mobile package root:
//
//   dart run tool/openapi/generate.dart
//
// Everything under lib/generated/ is machine output and is never hand-edited.
// To change it, change the contract or the options in this file, then rerun.
import 'dart:io';

/// Generator options. `pubName`/`sourceFolder` make the emitted imports resolve
/// as `package:school_mobile/generated/...`, so the output drops straight into
/// this package instead of being a nested package of its own.
const String generatorName = 'dart-dio';
// serializationLibrary: built_value is deliberate. The json_serializable
// template is marked BETA upstream and emits an empty `operator ==`/`hashCode`
// body (invalid Dart) for the contract's property-less `anyOf` tuple schemas,
// e.g. the `permissions: ['*']` shape. built_value renders those as AnyOf and
// compiles.
const String additionalProperties = 'pubName=school_mobile,'
    'sourceFolder=generated,'
    'serializationLibrary=built_value,'
    'hideGenerationTimestamp=true';

const String specPath = '../laravel-api/openapi.yaml';
const String configPath = 'tool/openapi/openapi_generator_config.json';
const String readmeTemplate = 'tool/openapi/generated_readme.md';
const String stagingDir = '.dart_tool/openapi_staging';
const String outputDir = 'lib/generated';

void main(List<String> args) async {
  _requirePackageRoot();

  final spec = File(specPath);
  if (!spec.existsSync()) {
    _fail('OpenAPI contract not found at $specPath. '
        'Generate it in laravel-api first (php artisan openapi:generate).');
  }

  _step('Resolving package dependencies');
  _run('flutter', ['pub', 'get']);

  _step('Clearing staging directory');
  final staging = Directory(stagingDir);
  if (staging.existsSync()) staging.deleteSync(recursive: true);

  _step('Running OpenAPI Generator ($generatorName)');
  _run(Platform.resolvedExecutable, [
    'run',
    'openapi_generator_cli:main',
    'generate',
    '--config',
    configPath,
    '-i',
    specPath,
    '-g',
    generatorName,
    '-o',
    stagingDir,
    '--additional-properties=$additionalProperties',
  ]);

  final produced = Directory('$stagingDir/lib/generated');
  if (!produced.existsSync()) {
    _fail('Generator produced no output at ${produced.path}.');
  }

  _step('Replacing $outputDir with fresh output');
  final output = Directory(outputDir);
  if (output.existsSync()) output.deleteSync(recursive: true);
  output.createSync(recursive: true);
  _copyDirectory(produced, output);

  // The generator also emits a root barrel that re-exports every model and API.
  // It belongs with the rest of the output rather than at the package root.
  final barrel = File('$stagingDir/lib/school_mobile.dart');
  if (barrel.existsSync()) {
    barrel.copySync('$outputDir/school_mobile.dart');
  }

  _step('Writing $outputDir/README.md');
  File(readmeTemplate).copySync('$outputDir/README.md');

  _step('Running build_runner for built_value');
  _run(Platform.resolvedExecutable, [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);

  staging.deleteSync(recursive: true);

  final models = Directory('$outputDir/model').listSync().length;
  final apis = Directory('$outputDir/api').listSync().length;
  stdout.writeln('\nDone. $models model files, $apis API files in $outputDir.');
}

void _requirePackageRoot() {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync() ||
      !pubspec.readAsStringSync().contains('name: school_mobile')) {
    _fail('Run this from the school-mobile package root:\n'
        '  dart run tool/openapi/generate.dart');
  }
}

void _run(String executable, List<String> arguments) {
  final result = Process.runSync(
    executable,
    arguments,
    runInShell: Platform.isWindows,
  );
  if (result.exitCode != 0) {
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    _fail('$executable ${arguments.join(' ')} failed '
        '(exit ${result.exitCode}).');
  }
}

void _copyDirectory(Directory from, Directory to) {
  for (final entity in from.listSync(recursive: true)) {
    final relative = entity.path.substring(from.path.length + 1);
    if (entity is Directory) {
      Directory('${to.path}/$relative').createSync(recursive: true);
    } else if (entity is File) {
      final target = File('${to.path}/$relative');
      target.parent.createSync(recursive: true);
      entity.copySync(target.path);
    }
  }
}

void _step(String message) => stdout.writeln('==> $message');

Never _fail(String message) {
  stderr.writeln('error: $message');
  exit(1);
}
