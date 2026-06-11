<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NotificationTemplate extends Model
{
    use HasFactory;

    protected $fillable = [
        'key', 'category', 'title_template', 'body_template',
        'default_priority', 'action_url_template', 'requires_action'
    ];

    protected $casts = [
        'requires_action' => 'boolean',
    ];

    /**
     * Get template by key, or return default if not found
     */
    public static function getByKey(string $key): ?self
    {
        return self::where('key', $key)->first();
    }

    /**
     * Render template with provided data
     */
    public function render(array $data): array
    {
        $title = $this->renderTemplate($this->title_template, $data);
        $body = $this->renderTemplate($this->body_template, $data);
        $actionUrl = $this->action_url_template ? $this->renderTemplate($this->action_url_template, $data) : null;

        return [
            'title' => $title,
            'body' => $body,
            'action_url' => $actionUrl,
            'priority' => $this->default_priority,
            'category' => $this->category,
            'requires_action' => $this->requires_action,
        ];
    }

    /**
     * Simple template rendering with {{variable}} syntax
     */
    protected function renderTemplate(string $template, array $data): string
    {
        return preg_replace_callback('/\{\{(\w+)\}\}/', function ($matches) use ($data) {
            $key = $matches[1];
            return $data[$key] ?? $matches[0];
        }, $template);
    }

    /**
     * Seed default templates
     */
    public static function seedDefaults(): void
    {
        $templates = [
            [
                'key' => 'assignment_created',
                'category' => 'academic',
                'title_template' => 'New Assignment: {{subject}}',
                'body_template' => 'A new assignment "{{title}}" has been posted for {{subject}}. Due: {{due_date}}',
                'default_priority' => 'normal',
                'action_url_template' => '/assignments/{{assignment_id}}',
            ],
            [
                'key' => 'assignment_due_soon',
                'category' => 'academic',
                'title_template' => 'Assignment Due Soon',
                'body_template' => '"{{title}}" is due in {{hours}} hours. Don\'t forget to submit!',
                'default_priority' => 'high',
                'action_url_template' => '/assignments/{{assignment_id}}',
            ],
            [
                'key' => 'submission_graded',
                'category' => 'academic',
                'title_template' => 'Assignment Graded: {{title}}',
                'body_template' => 'Your submission for "{{title}}" has been graded. Score: {{score}}/{{max_score}}',
                'default_priority' => 'normal',
                'action_url_template' => '/grades/{{submission_id}}',
            ],
            [
                'key' => 'grade_posted',
                'category' => 'academic',
                'title_template' => 'New Grade: {{subject}}',
                'body_template' => 'A new grade has been posted for {{subject}}: {{component}} ({{score}}/{{max_score}})',
                'default_priority' => 'normal',
                'action_url_template' => '/grades',
            ],
            [
                'key' => 'absence_alert',
                'category' => 'academic',
                'title_template' => 'Absence Alert',
                'body_template' => '{{student_name}} was marked absent on {{date}}.',
                'default_priority' => 'high',
                'action_url_template' => '/attendance',
            ],
            [
                'key' => 'fee_invoice_created',
                'category' => 'financial',
                'title_template' => 'New Fee Invoice',
                'body_template' => 'A new invoice for {{description}} has been generated. Amount: {{amount}}. Due: {{due_date}}',
                'default_priority' => 'normal',
                'action_url_template' => '/invoices/{{invoice_id}}',
            ],
            [
                'key' => 'fee_reminder',
                'category' => 'financial',
                'title_template' => 'Fee Reminder',
                'body_template' => 'Reminder: Invoice {{invoice_no}} for {{amount}} is due in {{days}} days.',
                'default_priority' => 'high',
                'action_url_template' => '/invoices/{{invoice_id}}',
            ],
            [
                'key' => 'payment_received',
                'category' => 'financial',
                'title_template' => 'Payment Received',
                'body_template' => 'Payment of {{amount}} for {{description}} has been received.',
                'default_priority' => 'normal',
                'action_url_template' => '/payments/{{payment_id}}',
            ],
            [
                'key' => 'announcement',
                'category' => 'administrative',
                'title_template' => '{{school_name}} Announcement',
                'body_template' => '{{title}}: {{preview}}',
                'default_priority' => 'normal',
                'action_url_template' => '/announcements/{{announcement_id}}',
            ],
            [
                'key' => 'message_received',
                'category' => 'administrative',
                'title_template' => 'New Message from {{sender_name}}',
                'body_template' => '{{preview}}',
                'default_priority' => 'normal',
                'action_url_template' => '/messages/{{conversation_id}}',
            ],
            [
                'key' => 'hr_request_approved',
                'category' => 'administrative',
                'title_template' => 'Request Approved',
                'body_template' => 'Your {{request_type}} request has been approved.',
                'default_priority' => 'normal',
                'action_url_template' => '/hr-requests/{{request_id}}',
            ],
            [
                'key' => 'hr_request_rejected',
                'category' => 'administrative',
                'title_template' => 'Request Rejected',
                'body_template' => 'Your {{request_type}} request has been rejected. Reason: {{reason}}',
                'default_priority' => 'high',
                'action_url_template' => '/hr-requests/{{request_id}}',
            ],
            [
                'key' => 'conduct_positive',
                'category' => 'behavioral',
                'title_template' => 'Positive Behavior Note',
                'body_template' => '{{student_name}} received positive recognition: {{title}}',
                'default_priority' => 'normal',
                'action_url_template' => '/conduct/{{student_id}}',
            ],
            [
                'key' => 'conduct_warning',
                'category' => 'behavioral',
                'title_template' => 'Behavior Warning',
                'body_template' => 'A behavior note has been logged for {{student_name}}: {{title}}',
                'default_priority' => 'high',
                'action_url_template' => '/conduct/{{student_id}}',
            ],
            [
                'key' => 'exam_scheduled',
                'category' => 'academic',
                'title_template' => 'Exam Scheduled: {{subject}}',
                'body_template' => '{{title}} scheduled for {{date}} at {{time}} in {{room}}',
                'default_priority' => 'high',
                'action_url_template' => '/exams/{{exam_id}}',
            ],
            [
                'key' => 'timetable_change',
                'category' => 'academic',
                'title_template' => 'Timetable Updated',
                'body_template' => 'Your class timetable has been updated. Please check the new schedule.',
                'default_priority' => 'normal',
                'action_url_template' => '/timetable',
            ],
            [
                'key' => 'system_maintenance',
                'category' => 'system',
                'title_template' => 'System Maintenance',
                'body_template' => 'The system will be under maintenance on {{date}} from {{start_time}} to {{end_time}}.',
                'default_priority' => 'normal',
                'action_url_template' => null,
            ],
            [
                'key' => 'budget_overrun',
                'category' => 'financial',
                'title_template' => '⚠️ Budget Alert: {{category}}',
                'body_template' => "Category '{{category}}' has reached {{usage_percent}}% of budget (Actual: {{actual}}, Planned: {{planned}})",
                'default_priority' => 'high',
                'action_url_template' => '/accounting/budget',
            ],
            [
                'key' => 'contract_expiry_alert',
                'category' => 'administrative',
                'title_template' => '📋 Contract Expiring: {{employee_name}}',
                'body_template' => "{{employee_name}}'s contract expires on {{contract_end}} ({{days_remaining}} days remaining). Please take action.",
                'default_priority' => 'high',
                'action_url_template' => '/hr/staff/{{employee_id}}',
            ],
            [
                'key' => 'low_stock_alert',
                'category' => 'administrative',
                'title_template' => '⚠️ Low Stock: {{item_name}}',
                'body_template' => "Item '{{item_name}}' (SKU: {{sku}}) is at {{current_qty}} {{unit}}, below minimum of {{min_qty}} {{unit}}.",
                'default_priority' => 'high',
                'action_url_template' => '/warehouse/inventory/{{item_id}}',
            ],
            [
                'key' => 'new_purchase_request',
                'category' => 'administrative',
                'title_template' => 'New Purchase Request: {{item_name}}',
                'body_template' => "{{requested_by_name}} requested {{quantity}} {{unit}} of {{item_name}}.",
                'default_priority' => 'normal',
                'action_url_template' => '/warehouse/purchase-requests/{{request_id}}',
            ],
            [
                'key' => 'contract_expiry_alert',
                'category' => 'administrative',
                'title_template' => 'Contract Expiring: {{employee_name}}',
                'body_template' => "{{employee_name}}'s contract expires on {{contract_end}} ({{days_remaining}} days remaining).",
                'default_priority' => 'high',
                'action_url_template' => '/hr/staff/{{employee_id}}',
            ],
            [
                'key' => 'purchase_request_status',
                'category' => 'administrative',
                'title_template' => 'Purchase Request {{status}}: {{item_name}}',
                'body_template' => "Your purchase request for {{item_name}} ({{quantity}} {{unit}}) has been {{status}}. Notes: {{admin_notes}}",
                'default_priority' => 'normal',
                'action_url_template' => '/warehouse/purchase-requests/{{request_id}}',
            ],
        ];

        foreach ($templates as $template) {
            self::updateOrCreate(['key' => $template['key']], $template);
        }
    }
}
