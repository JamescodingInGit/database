<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Movie;
use App\Models\ShowtimeDetails;
use App\Models\Promotion;
use Carbon\Carbon;

class HomeController extends Controller
{
    public function showHome()
    {
        $movie = Movie::all();
        $promotion = Promotion::all();

        return view('page/home', ['movies' => $movie,'promotion' => $promotion]);
    }

    public function redirect($movieiD){
        $date = Carbon::now()->format('Y-m-d');
        $showTime = ShowtimeDetails::where('movieID', $movieiD)->whereDate('movieDateTime', $date)
        ->orderBy('cinemaName')->get();
        $movie = Movie::where('movieID', $movieiD)->first();
        $cinemaName = $showTime->first()->cinemaName;
        return redirect('/details/' . rawurlencode($movie->movieTitle) . '/' . $date . '/' . rawurlencode($cinemaName));
    }
}
