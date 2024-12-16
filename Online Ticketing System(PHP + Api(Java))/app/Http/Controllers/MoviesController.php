<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Movie;
use App\Models\ShowtimeDetails;
use App\Models\TicketType;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;
use Illuminate\Support\Facades\Session;

class MoviesController extends Controller
{
    // In MovieController.php
    public function showImageHorizontal($id)
    {
        $movie = Movie::where('movieID', $id)->first();
        
        if (!$movie || !$movie->movieImageHori) {
            abort(404); // Return a 404 if the movie or image is not found
        }

        // Determine the mime type of the image
        $mimeType = 'image/jpeg'; // Adjust if you are storing different image types

        return Response::make($movie->movieImageHori, 200, ['Content-Type' => $mimeType]);
    }

    public function showImageVertical($id)
    {
        $movie = Movie::where('movieID', $id)->first();
        
        if (!$movie || !$movie->movieImageVer) {
            abort(404); // Return a 404 if the movie or image is not found
        }

        // Determine the mime type of the image
        $mimeType = 'image/jpeg'; // Adjust if you are storing different image types

        return Response::make($movie->movieImageVer, 200, ['Content-Type' => $mimeType]);
    }

    public function showMovieDetails($title, $date, $cinemaName) {
        $movie = Movie::where('movieTitle', $title)->first();
    
        $today = Carbon::now();
        $currentWednesday = $today->copy()->startOfWeek()->addDays(2); // This week's Wednesday
        $nextWednesday = $currentWednesday->copy()->addWeek(); // Next week's Wednesday
        
        // Get the showtimes and filter them by the current and next Wednesday
        $showTime = ShowtimeDetails::where('movieID', $movie->movieID)
            ->get()
            ->filter(function($showTime) use ($currentWednesday, $nextWednesday) {
                $movieDateTime = Carbon::parse($showTime->movieDateTime);
                return $movieDateTime->between($currentWednesday, $nextWednesday);
        });

        // Group showtimes by date
        $showTimesDates = $showTime->groupBy(function($showTime) {
            return Carbon::parse($showTime->movieDateTime)->format('Y-m-d');
        });

        $date = Carbon::parse($date);

        $cinemas = $showTime->filter(function($showTime) use ($date) {
            $movieDateTime = Carbon::parse($showTime->movieDateTime);

            return $movieDateTime->isFuture() && $movieDateTime->isSameDay($date);
        })
        ->groupBy(function($showTime) {
            return $showTime->location; 
        })
        ->map(function($groupedByLocation) {
            return $groupedByLocation->groupBy(function($showTime) {
                return $showTime->cinemaName; 
            });
        });

        $showTimeList = $this->filterShowTime($showTime, $date, $cinemaName);
    
        $cinemaLocation = $showTimeList->first()->first()->location;

        return view('page/details', compact('movie', 'showTimesDates', 'cinemas', 'showTimeList','cinemaLocation', 'cinemaName'));
    }

    public function filterShowTime($showTime, $date, $cinemaName){
        $showTimeList = $showTime->filter(function($showTime) use ($date, $cinemaName) {
            $movieDateTime = Carbon::parse($showTime->movieDateTime);
        
            // Filter by future showtimes, date, and cinema name
            return $movieDateTime->isFuture() 
                && $movieDateTime->isSameDay($date)
                && $showTime->cinemaName === $cinemaName;
        })
        ->groupBy(function($showTime) {
            return $showTime->movieExperience; 
        });

        return $showTimeList;
    }
    
    public function showSeat($showID){
        $showTime = ShowtimeDetails::where('showID', $showID)->first();
        $movie = Movie::where('movieID', $showTime->movieID)->first();
        $tickets = TicketType::where('showID', $showID)->get();

        return view('page/seat', compact('showTime', 'movie', 'tickets'));
    }

    public function addSeatCart(Request $request) {
        Session::forget('showID');
        Session::forget('seats');
        Session::forget('ticket');

        $ticketDetails = $request->input('tickets'); 
        $showID = $request->input('showID'); 
        $seats = $request->input( 'seat'); 
        

        Session::put('showID', $showID); 
        Session::put('seats', $seats); 

        // Array to store ticket data
        $ticketsToStore = [];
    
        foreach ($ticketDetails as $index => $ticket) {
            $quantity = $ticket['quantity'];
    
            // Only store if quantity is greater than 0
            if ($quantity > 0) {
                $ticketsToStore[] = [
                    'type' => $ticket['type'],
                    'price' => $ticket['price'],
                    'quantity' => $quantity
                ];
            }
        }
        Session::put('ticket', json_encode($ticketsToStore));
    
        return redirect('/foodDrink');
    }
    
}
