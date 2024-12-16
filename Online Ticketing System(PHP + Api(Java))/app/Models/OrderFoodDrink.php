<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderFoodDrink extends Model
{
    use HasFactory;

    public function foodDrink() {
        return $this->belongsTo(FoodDrink::class, 'foodDrinkID', 'foodDrinkID');
    }

}
