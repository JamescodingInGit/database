<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('order_food_drinks', function (Blueprint $table) {
            $table->integer('orderNo')->unsigned();
            $table->integer('foodDrinkID')->unsigned();
            $table->integer('quantity');
            $table->primary(['orderNo', 'foodDrinkID']);
            $table->foreign('orderNo')->references('orderNo')->on('orders');
            $table->foreign('foodDrinkID')->references('foodDrinkID')->on('food_drinks');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_food_drinks');
    }
};
