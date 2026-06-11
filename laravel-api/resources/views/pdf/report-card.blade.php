<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Report Card — {{ $student->name }}</title>
<style>
  body { font-family: DejaVu Sans, sans-serif; font-size: 12px; color: #222; }
  h1 { font-size: 22px; margin: 0 0 4px; }
  h2 { font-size: 14px; margin: 18px 0 6px; }
  .meta div { margin: 2px 0; }
  table { width: 100%; border-collapse: collapse; margin-top: 6px; }
  th, td { border: 1px solid #ccc; padding: 5px 7px; text-align: left; }
  th { background: #f0f0f0; }
  .avg { font-weight: bold; background: #fafafa; }
</style>
</head>
<body>
  <h1>Academic Report Card</h1>
  <div class="meta">
    <div><strong>Student:</strong> {{ $student->name }}</div>
    <div><strong>Class:</strong> {{ $student->studentProfile->classRoom->name ?? '—' }}</div>
    <div><strong>Admission #:</strong> {{ $student->studentProfile->admission_no ?? '—' }}</div>
    <div><strong>Generated:</strong> {{ now()->format('Y-m-d H:i') }}</div>
  </div>

  @foreach($bySubject as $subjectName => $row)
    <h2>{{ $subjectName }}</h2>
    <table>
      <thead><tr><th>Component</th><th>Type</th><th>Score</th><th>Max</th><th>Weight</th></tr></thead>
      <tbody>
        @foreach($row['scores'] as $s)
          <tr>
            <td>{{ $s['component'] }}</td>
            <td>{{ $s['type'] }}</td>
            <td>{{ number_format((float)$s['score'], 2) }}</td>
            <td>{{ number_format((float)$s['max_score'], 2) }}</td>
            <td>{{ number_format((float)$s['weight'], 2) }}</td>
          </tr>
        @endforeach
        <tr class="avg">
          <td colspan="4">Cumulative percentage</td>
          <td>{{ $row['cumulative_pct'] !== null ? $row['cumulative_pct'] . '%' : '—' }}</td>
        </tr>
      </tbody>
    </table>
  @endforeach
</body>
</html>
