<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ViewOrder</title>
        <link rel="stylesheet" href="{{asset('orderView.css')}}"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    </head>

    <body>
        <a href="{{ route('myticket') }}" class="back-link"><i class="fa-solid fa-chevron-left"></i></a>
        <div class="ticket-container">
            <div class="order-header">
                <div class="status-icon">
                    <i class="fa fa-check-circle"></i>
                </div>
                <div class="order-number">
                    <h2>Order Successful</h2>
                    <p>Order No: {{ $order->orderNo }}</p>
                </div>
            </div>

            <div class="qr-code">
                <img src="{{ asset('qr.svg') }}">
                <p>SHOW YOUR CODE AT ENTRY POINT</p>
            </div>

            <div class="movie-details">
                <h3>{{ $firstTicket->type->show->hall->cinema->cinemaName }}</h3> <!-- Cinema Name -->
                <p><i class="fa-solid fa-video"></i>&nbsp {{ $firstTicket->type->show->movie->movieTitle }}</p> <!-- Movie Title -->
                <p><i class="fa-solid fa-boxes-stacked"></i>&nbsp Hall ID: {{ $firstTicket->type->show->hall->hallID }}</p> <!-- Hall ID -->
                <p><i class="fa-solid fa-couch"></i>&nbsp Seats: {{ $seats }}</p> <!-- All seats -->
                <p><i class="fa-solid fa-calendar-days"></i>&nbsp {{ $formattedMovieDateTime }}</p> <!-- Movie date/time -->
            </div>

            <div class="order-details">
                <h4>ORDER DETAILS</h4>
                <p>Transaction Date:&nbsp {{ $formattedTransactionDate }}</p> <!-- Transaction Date -->
                <p>Transaction Time:&nbsp {{ $formattedTransactionTime }}</p> <!-- Transaction Time -->
                <hr>
                <h4>SEATS</h4>
                @foreach ($order->tickets as $ticket)
                <p>{{ $ticket->type->type }} ({{ $ticket->seat }}): RM {{ $ticket->type->price }}</p> <!-- Ticket Type, Seat, and Price -->
                @endforeach
                <hr>
                <h4>FOOD & DRINKS</h4>
                @if($order->orderFoodDrinks->isNotEmpty())
                @foreach($order->orderFoodDrinks as $foodDrinkOrder)
                <p>{{ $foodDrinkOrder->foodDrink->foodDrinkName }} ({{ $foodDrinkOrder->quantity }}): RM {{ $foodDrinkOrder->foodDrink->price }}</p>
                @endforeach
                @else
                <p>No Food & Drinks Ordered</p>
                @endif
                <hr>
                <h4>TOTAL</h4>
                <p>RM {{ number_format($totalAmount, 2) }}</p>
            </div>
        </div>


    </body>
</html>