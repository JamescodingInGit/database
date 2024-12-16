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
        Schema::create('order_tickets', function (Blueprint $table) {
            $table->integer('orderNo')->unsigned();
            $table->integer('typeID')->unsigned();
            $table->string('seat');
            $table->primary(['orderNo', 'seat']);
            $table->foreign('orderNo')->references('orderNo')->on('orders');
            $table->foreign('typeID')->references('typeID')->on('ticket_types');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_tickets');
    }
};
