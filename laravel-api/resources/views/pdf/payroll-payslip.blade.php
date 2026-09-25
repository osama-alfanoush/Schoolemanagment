<!doctype html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="utf-8">
    <style>
        body { font-family: DejaVu Sans, sans-serif; direction: rtl; color: #172033; font-size: 12px; }
        h1 { margin: 0 0 6px; font-size: 22px; }
        .muted { color: #64748b; }
        .summary { display: table; width: 100%; margin: 18px 0; }
        .summary div { display: table-cell; border: 1px solid #dbe2ea; padding: 10px; text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 14px; }
        th, td { border: 1px solid #dbe2ea; padding: 8px; text-align: right; }
        th { background: #f1f5f9; }
        .amount { text-align: left; direction: ltr; }
        .net { margin-top: 18px; padding: 14px; background: #e8f7ef; font-size: 17px; font-weight: bold; }
        .formula { margin-top: 14px; padding: 10px; border: 1px dashed #94a3b8; }
    </style>
</head>
<body>
    <h1>قسيمة راتب</h1>
    <div class="muted">الدورة {{ $record->run?->run_no }} — {{ sprintf('%02d/%d', $record->month, $record->year) }}</div>
    <p><strong>الموظف:</strong> {{ $record->staff?->name }} &nbsp; | &nbsp; <strong>الرقم الوظيفي:</strong> {{ $record->staff?->staffProfile?->employee_no ?? '-' }}</p>
    <div class="summary">
        <div>الأساسي<br><strong>{{ number_format((float) $record->base_salary, 2) }}</strong></div>
        <div>الإجمالي<br><strong>{{ number_format((float) $record->gross_salary, 2) }}</strong></div>
        <div>صافي الراتب<br><strong>{{ number_format((float) $record->net_pay, 2) }}</strong></div>
    </div>
    <table>
        <thead><tr><th>البند</th><th>التصنيف</th><th>طريقة الحساب</th><th class="amount">القيمة</th></tr></thead>
        <tbody>
            <tr><td>الراتب الأساسي</td><td>استحقاق</td><td>ثابت</td><td class="amount">{{ number_format((float) $record->base_salary, 2) }}</td></tr>
            @foreach($record->components as $component)
                <tr>
                    <td>{{ $component->name_ar }}</td>
                    <td>{{ $component->category === 'earning' ? 'استحقاق' : ($component->category === 'deduction' ? 'اقتطاع' : 'مساهمة صاحب العمل') }}</td>
                    <td>{{ $component->calculation_type === 'percentage' ? 'نسبة' : 'ثابت' }}</td>
                    <td class="amount">{{ number_format((float) $component->amount, 2) }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
    <div class="formula">
        <strong>معادلة الصافي:</strong>
        {{ number_format((float) $record->base_salary, 2) }} + {{ number_format((float) $record->total_earnings, 2) }}
        − {{ number_format((float) $record->employee_social_insurance, 2) }}
        − {{ number_format((float) $record->other_deductions, 2) }}
        − {{ number_format((float) $record->advance_deduction, 2) }}
    </div>
    <div class="net">الصافي المستحق: {{ number_format((float) $record->net_pay, 2) }}</div>
    <p class="muted">تم تثبيت نسخة العقد ونظام الضمان وقواعد المكونات ضمن سجل هذه الدورة.</p>
</body>
</html>
