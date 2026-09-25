<!doctype html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="utf-8">
    <style>
        body { font-family: DejaVu Sans, sans-serif; color: #172033; font-size: 13px; }
        h1 { color: #5b3cc4; margin-bottom: 4px; }
        .meta { color: #667085; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { border: 1px solid #d9dce5; padding: 8px; text-align: right; }
        th { background: #f3f0ff; }
        .total { font-size: 18px; font-weight: bold; margin-top: 20px; }
    </style>
</head>
<body>
    <h1>سند قبض {{ $receipt->receipt_no }}</h1>
    <div class="meta">الحالة: {{ $receipt->status }} — التاريخ: {{ $receipt->receipt_date->format('Y-m-d') }}</div>
    <p><strong>الطالب:</strong> {{ $receipt->student->name }}</p>
    <p><strong>طريقة الدفع:</strong> {{ $receipt->method }} @if($receipt->reference) — {{ $receipt->reference }} @endif</p>
    <table>
        <thead><tr><th>الفاتورة</th><th>البيان</th><th>المبلغ</th></tr></thead>
        <tbody>
        @foreach($receipt->allocations as $allocation)
            <tr><td>{{ $allocation->invoice->invoice_no }}</td><td>{{ $allocation->invoice->description }}</td><td>{{ number_format($allocation->amount, 2) }}</td></tr>
        @endforeach
        </tbody>
    </table>
    <div class="total">الإجمالي: {{ number_format($receipt->amount, 2) }}</div>
    @if($receipt->note)<p>{{ $receipt->note }}</p>@endif
</body>
</html>
