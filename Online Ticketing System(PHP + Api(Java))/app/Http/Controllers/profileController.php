<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Models\Order;

class profileController extends Controller {

    public function myticket(Request $request) {
    $email = $request->session()->get('email');
    $user = User::where('email', $email)->first();
    if (!$user) {
        return redirect('someErrorPage')->with('error', 'User not found');
    }
    $userID = $user->userID;

    // Get all orders and group tickets by orderNo
    $userTickets = DB::table('orders')
            ->join('order_tickets', 'orders.orderNo', '=', 'order_tickets.orderNo')
            ->join('ticket_types', 'order_tickets.typeID', '=', 'ticket_types.typeID')
            ->join('show_times', 'ticket_types.showID', '=', 'show_times.showID')
            ->join('movies', 'show_times.movieID', '=', 'movies.movieID')
            ->join('halls', 'show_times.hallID', '=', 'halls.hallID')
            ->join('cinemas', 'halls.cinemaID', '=', 'cinemas.cinemaID')
            ->select(
                    'orders.orderNo',
                    'orders.QRCode',
                    'order_tickets.seat',
                    'cinemas.cinemaName',
                    'movies.movieTitle',
                    'movies.movieImage',
                    'movies.runningTime',
                    'show_times.movieDateTime'
            )
            ->where('orders.userID', $userID)
            ->orderBy('orders.orderNo') // Order by orderNo for grouping
            ->get()
            ->groupBy('orderNo'); // Group tickets by orderNo

    $request->session()->put('user', $user);
    return view('myticket', compact('user', 'userTickets'));
}

    
    public function viewOrder(Request $request, $orderNo) {
        // Retrieve a single order, with its related tickets, types, shows, movies, halls, and order food & drinks
        $order = Order::where('orderNo', $orderNo)
                ->with(['tickets.type.show.movie', 'tickets.type.show.hall', 'orderFoodDrinks.foodDrink'])
                ->first();

        // Optionally handle if no order is found
        if (!$order) {
            return redirect('someErrorPage')->with('error', 'Order not found');
        }

        // Extracting seats as a comma-separated string
        $seats = $order->tickets->pluck('seat')->implode(', ');

        // Get the first ticket
        $firstTicket = $order->tickets->first();

        // Formatting the transaction date and time
        $formattedMovieDateTime = Carbon::parse($firstTicket->type->show->movieDateTime)->format('Y-m-d h:i A');
        $formattedTransactionDate = Carbon::parse($order->created_at)->format('d F Y');
        $formattedTransactionTime = Carbon::parse($order->created_at)->format('h:i A');

        // Calculate total amount: tickets total + food & drinks total
        $ticketTotal = $order->tickets->sum(function ($ticket) {
            return $ticket->type->price;
        });

        $foodDrinkTotal = $order->orderFoodDrinks->sum(function ($foodDrinkOrder) {
            return $foodDrinkOrder->quantity * $foodDrinkOrder->foodDrink->price;
        });

        $totalAmount = $ticketTotal + $foodDrinkTotal;

        // Pass the order, seats, and total amount to the view
        return view('viewOrder', compact('order', 'seats', 'firstTicket', 'formattedMovieDateTime', 'formattedTransactionDate', 'formattedTransactionTime', 'totalAmount'));
    }

    public function editProfile(Request $request) {
        // Retrieve the user's ID from the session
        $userID = $request->session()->get('user.userID');

        // Check if userID exists in the session
        if (!$userID) {
            // Redirect to error page if no userID is found
            return redirect('someErrorPage')->with('error', 'User not found');
        }

        // Fetch the user data from the database using the userID
        $user = User::find($userID);

        // Check if the user exists in the database
        if (!$user) {
            // Redirect to error page if the user doesn't exist in the database
            return redirect('someErrorPage')->with('error', 'User not found in the database');
        }

        // Update the session with the latest user data
        $request->session()->put('user', $user);

        // Pass the updated user to the view
        return view('editProfile', compact('user'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function changePass(Request $request) {
        // Retrieve the user's email from the session
        $user = $request->session()->get('user');

        // Check if user exists
        if (!$user) {
            // Optionally handle the case where the user is not found
            return redirect('someErrorPage')->with('error', 'User not found');
        }

        // Pass the user to the view
        return view('changePass', compact('user'));
    }

    public function changePassEdit(Request $request) {
        // Get the current authenticated user
        $user = Auth::user();

        // Check if the user exists
        if ($user) {
            // Check if the provided current password matches the user's actual password
            if (!Hash::check($request->input('password'), $user->password)) {
                return redirect('changePass')->with('error', 'The current password is incorrect.');
            }

            // Check if the new password and the confirmation password match
            $newPassword = $request->input('newPass');

            $user->password = $newPassword;

            // Save the user and check if save is successful
            if ($user->save()) {
                // If successful, redirect with a success message
                return redirect('myticket')->with('success', 'Password changed successfully.');
            } else {
                // If save fails, return to changePass with an error message
                return redirect('changePass')->with('error', 'Password change failed. Please try again.');
            }
        } else {
            // If user is not found, return with an error
            return redirect('changePass')->with('error', 'User not found.');
        }
    }

    public function destroyUser(string $userID) {
        // Find the user by ID
        $user = User::find($userID);

        if ($user) {
            $user->delete();
            // Log out the user (if the user being deleted is the currently authenticated one)
            Auth::logout();
            // Invalidate the current session
            session()->invalidate();
            // Regenerate CSRF token to avoid token mismatch issues
            session()->regenerateToken();
            return redirect('/login')->with('success', 'Your account has been successfully deleted.');
        } else {
            // If user is not found, return with an error
            return redirect('myticket')->with('error', 'User not found.');
        }
    }

}
