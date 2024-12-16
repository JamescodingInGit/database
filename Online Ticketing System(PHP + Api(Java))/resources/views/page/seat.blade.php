<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>TGV</title>
        <link rel="stylesheet" href="{{asset('css/seat.css')}}">
        <link rel="stylesheet" href="{{asset('css/progress.css')}}">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="{{asset('js/seat.js')}}"></script>
    </head>
    <body>
        <nav class="navbar top">
            <div class="logo">
                <img src="{{ asset('image/tgv-logo.png') }}" alt="TGV Logo">
            </div>
            <div class="stepper-wrapper">
                <div class="stepper-item completed">
                    <div class="step-counter">1</div>
                    <div class="step-name">Select Seats</div>
                </div>
                <div class="stepper-item">
                    <div class="step-counter">2</div>
                    <div class="step-name">Food & Drinks</div>
                </div>
                <div class="stepper-item active">
                    <div class="step-counter">3</div>
                    <div class="step-name">Checkout & Payment</div>
                </div>
            </div>
            <a class="close-button" href="{{ url('details/' . rawurlencode($movie['movieTitle']) . '/' .  \Carbon\Carbon::parse($showTime['movieDateTime'])->format('Y-m-d')  . '/' . rawurlencode($showTime['cinemaName'])) }}">&times;</a> <!-- Close button -->
        </nav>
        <div class="movie-container">
            <div class="movie" style="background: url({{ route('movie.imageHorizontal', ['id' => $movie['movieID']]) }})">
                <div class="movieGradientBtt"></div>
                <div class="movie-content">
                    <h2>{{$movie['movieTitle']}}</h2>
                    @php
                        $hours = floor($movie['runningTime'] / 60); // Get the number of hours
                        $minutes = $movie['runningTime'] % 60; // Get the remaining minutes
                    @endphp
                    <table class="movie-info">
                        <tr>
                            <td><x-class-logo :class="$movie['classification']" ></x-class-logo></td>
                            <td><p>{{$movie['genre']}} &#124; {{$hours}} hr {{$minutes}} mins &#124; {{$movie['spokenLanguage']}}</p></td>
                        </tr>
                    </table>
                    <table class="movie-location-date">
                        <tr>
                            <td>{{$showTime['cinemaName']}}</td>
                            <td>{{$showTime['movieExperience']}}</td>
                            <td>{{ \Carbon\Carbon::parse($showTime['movieDateTime'])->format('d M Y, g:i A') }}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="seat-container">
          <ul class="showcase">
            <li>
              <div class="seat"></div>
              <small>Available</small>
            </li>
            <li>
              <div class="seat selected"></div>
              <small>Selected</small>
            </li>
            <li>
              <div class="seat occupied"></div>
              <small>Occupied</small>
            </li>
          </ul>
      
          <div>
            <div class="screen"><p>Screen</p></div>
                <div class="seat-selection"></div>
          </div>
        </div>
        
        <div class="booking-container">
            <button class="book-button disabled" onclick="openModal()">Book Now</button>
        </div>

        <div id="ticketModal" class="modal">
            <div class="modal-content">
                <div class="cart-header">
                    <span class="cart-icon">
                      <i class="fa fa-shopping-cart"></i>
                    </span>
                    <span class="cart-title">Select Tickets</span>
                    <span class="cart-arrow" onclick="closeModal()">
                        &times;
                    </span>
                  </div>
                
                  <div class="cart-movie-info" >
                    <h2 class="cart-movie-title">Transformers One</h2>
                    <div class="cart-movie-location">
                      <span class="location-icon"><i class="fa fa-map-marker"></i> Ampang Point</span>
                      <span class="cinema-icon"><i class="fa fa-film"></i> Cinema 5</span>
                    </div>
                    <div class="cart-movie-details">
                      <span class="date-icon"><i class="fa fa-calendar"></i> 17 Sep 2024, 9:00 PM</span>
                      <span class="seat-icon"><i class="fa fa-ticket"></i><span id="seat-names">None</span></span>
                    </div>
                  </div>
                <form action="{{ route('movie.addSeatCart', ['id' => $showTime['showID']]) }}" method="POST">
                    @csrf 
                    <div class="modal-body">
                        @foreach ($tickets as $ticket)
                            <div class="ticket-row">
                                <div class="ticketDetail">
                                    <h3>{{$ticket['type']}}</h3>
                                    <p>RM{{ number_format($ticket['price'], 2) }}</p>
                                </div>
                                <div class="ticket-selector">
                                    <button type="button" id="minus-button" onclick="updateTicketCount(-1, 0)">-</button>
                                    <input type="number" class="ticket-input" name="tickets[{{ $loop->index }}][quantity]" min="0" step="1" value="0" readonly>
                                    <input type="hidden" name="tickets[{{ $loop->index }}][type]" value="{{ $ticket['type'] }}">
                                    <input type="hidden" name="tickets[{{ $loop->index }}][price]" value="{{ $ticket['price'] }}">
                                    <button type="button" id="plus-button" onclick="updateTicketCount(1, 0)">+</button>
                                </div>
                            </div>
                        @endforeach
                    </div>
                    <input type="hidden" name="showID" value="{{$showTime['showID']}}" >
                    <input type="hidden" name="seat" value="" >
                
                            <div class="modal-footer">
                                <button type="submit" onclick="bookTickets()" class="book-button ">Book Tickets</button>
                            </div>
                        </div>
                    </div>
                </form>
        
        <script>
            // Convert PHP array to JSON
            const seatMap = @json($showTime['seatMap']);
            const soldMap = @json($showTime['seatSold']);
            
            // Call your JavaScript functions with the seatMap data
            load(seatMap, soldMap);
            navBar();
        </script>
    </body>
    
</html>
