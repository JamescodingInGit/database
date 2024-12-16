<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    public function tickets() {
        return $this->hasMany(OrderTicket::class, 'orderNo', 'orderNo');
    }

    public function orderFoodDrinks() {
        return $this->hasMany(OrderFoodDrink::class, 'orderNo', 'orderNo');
    }
}
