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
        Schema::create('promotions', function (Blueprint $table) {
            $table->string('promotionCode')->unique();
            $table->integer('movieID')->unsigned()->nullable()->constrained();
            $table->double('promotionValue');
            $table->text('promotionDescription');
            $table->string('paymentRequired');
            $table->string('movieExperienceRequired');
            $table->date('promotionStartDate');
            $table->date('promotionEndDate');
            $table->binary('promotionImage');
            $table->foreign('movieID')->references('movieID')->on('movies');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('promotions');
    }
};
