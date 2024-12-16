<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderTicket extends Model
{
    use HasFactory;

    public function type() {
        return $this->belongsTo(TicketType::class, 'typeID', 'typeID');
    }

    public function show() {
        return $this->belongsTo(ShowTime::class, 'showID', 'showID');
    }
}
