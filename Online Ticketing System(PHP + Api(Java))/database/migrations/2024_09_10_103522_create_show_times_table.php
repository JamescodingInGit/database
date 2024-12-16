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
        Schema::create('show_times', function (Blueprint $table) {
            $table->increments('showID')->unique();
            $table->timestamp('movieDateTime');
            $table->string('movieExperience');
            $table->json('seatSold');
            $table->integer('movieID')->unsigned();
            $table->integer('hallID')->unsigned();
            $table->foreign('movieID')->references('movieID')->on('movies');
            $table->foreign('hallID')->references('hallID')->on('halls');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('show_times');
    }
};
