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
        Schema::create('movies', function (Blueprint $table) {
            $table->increments('movieID')->unique();
            $table->string('movieTitle')->unique();
            $table->integer('runningTime');
            $table->text('synopsis');
            $table->date('releaseDate');
            $table->string('spokenLanguage');
            $table->json('subtitles');
            $table->string('genre');
            $table->string('classification');
            $table->string('director');
            $table->json('cast');
            $table->longText('movieImageHori')->charset('binary');
            $table->longText('movieImageVer')->charset('binary');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('movies');
    }
};
