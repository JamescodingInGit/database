<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        DB::statement("
            CREATE VIEW showtime_details AS
            SELECT
                st.showID,
                st.movieDateTime,
                st.movieExperience,
                st.seatSold,
                st.movieID,
                h.hallID,
                h.seatMap,
                h.seatNum,
                c.cinemaName,
                c.location,
                c.address
            FROM
                show_times AS st
            JOIN
                halls AS h ON st.hallID = h.hallID
            JOIN
                cinemas AS c ON h.cinemaID = c.cinemaID;
        ");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('showtime_details_view');
    }
};
