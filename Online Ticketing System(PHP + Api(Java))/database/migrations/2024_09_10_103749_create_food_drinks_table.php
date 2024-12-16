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
        Schema::create('food_drinks', function (Blueprint $table) {
            $table->increments('foodDrinkID')->unique();
            $table->string('foodDrinkName');
            $table->double('price');
            $table->string('type');
            $table->binary('foodDrinkImage');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('food_drinks');
    }
};
