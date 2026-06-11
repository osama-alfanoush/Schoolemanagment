<?php

namespace App\Mail;

use App\Models\Notification;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class NotificationEmail extends Mailable
{
    use Queueable, SerializesModels;

    public Notification $notification;

    public function __construct(Notification $notification)
    {
        $this->notification = $notification;
    }

    public function build(): self
    {
        return $this
            ->subject($this->notification->title)
            ->view('emails.notification')
            ->with([
                'title' => $this->notification->title,
                'body' => $this->notification->body,
                'actionUrl' => $this->notification->action_url,
            ]);
    }

    public function failed(\Throwable $e): void
    {
        Log::error('NotificationEmail failed to send', [
            'notification_id' => $this->notification->id,
            'title' => $this->notification->title,
            'error' => $e->getMessage(),
        ]);
    }
}
