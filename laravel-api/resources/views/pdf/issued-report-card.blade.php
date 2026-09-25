{{--
  The report card as it was issued.

  Rendered from the issue's own snapshot, never from today's marks. A report
  card is a document a member of staff signed off at a moment in time;
  regenerating it from live grades would hand a parent a different document
  under the same name and the same version number.

  The checksum is printed so a printed copy can be checked against the record.
--}}
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Report Card — {{ $studentName }}</title>
<style>
  body { font-family: DejaVu Sans, sans-serif; font-size: 12px; color: #222; }
  h1 { font-size: 22px; margin: 0 0 4px; }
  h2 { font-size: 14px; margin: 18px 0 6px; }
  .meta div { margin: 2px 0; }
  table { width: 100%; border-collapse: collapse; margin-top: 6px; }
  th, td { border: 1px solid #ccc; padding: 5px 7px; text-align: left; }
  th { background: #f0f0f0; }
  .footer { margin-top: 24px; font-size: 10px; color: #666; }
</style>
</head>
<body>
  <h1>Academic Report Card</h1>
  <div class="meta">
    <div><strong>Student:</strong> {{ $studentName }}</div>
    <div><strong>Class:</strong> {{ $className ?? '—' }}</div>
    <div><strong>Period:</strong> {{ $periodName ?? '—' }}</div>
    <div><strong>Issued:</strong> {{ $issue->issued_at?->format('Y-m-d') }}</div>
    <div><strong>Version:</strong> {{ $issue->issue_version }}</div>
  </div>

  @forelse ($books as $book)
    <h2>{{ $subjects[$book['subject_id']] ?? 'Subject' }}</h2>
    <table>
      <thead>
        <tr><th>Component</th><th>Score</th><th>Out of</th><th>Weight</th></tr>
      </thead>
      <tbody>
        @foreach ($book['components'] ?? [] as $component)
          <tr>
            <td>{{ $component['name'] ?? '—' }}</td>
            <td>{{ $component['score'] ?? '—' }}</td>
            <td>{{ $component['max_score'] ?? '—' }}</td>
            <td>{{ $component['weight'] ?? '—' }}</td>
          </tr>
        @endforeach
      </tbody>
    </table>
  @empty
    <p>No finalized results were recorded for this period.</p>
  @endforelse

  <div class="footer">
    Checksum: {{ $issue->checksum ?? '—' }}
  </div>
</body>
</html>
