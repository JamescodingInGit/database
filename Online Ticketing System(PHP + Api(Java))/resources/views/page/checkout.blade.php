<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>TGV</title>
        <link rel="stylesheet" href="{{asset('css/checkout.css')}}">
        <link rel="stylesheet" href="{{asset('css/progress.css')}}">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body>
        <nav class="navbar top">
            <div class="logo">
                <img src="{{asset('image/tgv-logo.png')}}" alt="TGV Logo">
            </div>
            <div class="stepper-wrapper">
                <div class="stepper-item completed">
                    <div class="step-counter">1</div>
                    <div class="step-name">Select Seats</div>
                </div>
                <div class="stepper-item completed">
                    <div class="step-counter">2</div>
                    <div class="step-name">Food & Drinks</div>
                </div>
                <div class="stepper-item completed">
                    <div class="step-counter">3</div>
                    <div class="step-name">Checkout & Payment</div>
                </div>
            </div>
            <button class="close-button">&times;</button> <!-- Close button -->
        </nav>
        
        <div class="movie-container">
            <div class="movie" style="background: url({{ route('movie.imageHorizontal', ['id' => $movie['movieID']]) }})">
                <div class="movieGradientBtt"></div>
                <div class="movie-content">
                    <h2>{{$movie['movieTitle']}}</h2>
                  <div class="movie-info">
                    <div class="movie-location">
                      <span class="location-icon"><i class="fa fa-map-marker"></i> <p>{{$showTime['cinemaName']}}</p></span>
                      <span class="cinema-icon"><i class="fa fa-film"></i> <p>Cinema {{$showTime['hallID']}}</p></span>
                    </div>
                    <div class="movie-details">
                      <span class="date-icon"><i class="fa fa-calendar"></i> <p>{{ \Carbon\Carbon::parse($showTime['movieDateTime'])->format('d M Y, g:i A') }}</p></span>
                      <span class="seat-icon"><i class="fa fa-film"></i><p>{{$showTime['movieExperience']}}</p></span>
                      <span class="seat-icon"><i class="fa fa-ticket"></i><p>{{$seats}}</p></span>
                    </div>
                  </div>
                </div>
            </div>
        </div>

        <div id="cartModal" class="modal">
            <div class="modal-content">
                
                <div class="modal-body">
                    <table>
                        <tr>
                            <th colspan="3" style="text-align: left">Seats</th>
                        </tr>
                        @php
                            $total = 0;
                        @endphp
                        @foreach ($tickets as $ticket)
                            <tr>
                                <td style="width:70%">{{$ticket['type']}}<br>RM{{number_format($ticket['price'], 2)}}</td>
                                <td style="width:20%">{{$ticket['quantity']}}</td>
                                <td style="width:10%">RM{{number_format($ticket['price'] * $ticket['quantity'], 2)}}</td>
                            </tr>
                            @php
                                $total += ($ticket['price'] * $ticket['quantity']);
                            @endphp
                        @endforeach
                        <tr><td colspan="3">
                            <a href="{{ url('seat/' . $showTime['showID']) }}" class="editBtn">Edit</a>
                        </td></tr>
                        <tr><td colspan="3"><hr></td></tr>
                        <tr>
                            <th colspan="3"  style="text-align: left">Food Drink</th>
                        </tr>
                        @if(Session::has('foodDrinks') && !empty(Session::get('foodDrinks')))
                        @foreach(Session::get('foodDrinks') as $foodDrink)
                            <tr>
                                <td style="width:70%">{{$foodDrink['foodDrinkName']}}<br>RM{{number_format($foodDrink['price']  , 2)}}</td>
                                <td style="width:20%">{{$foodDrink['quantity']}}</td>
                                <td style="width:10%">RM{{number_format($foodDrink['price'] *$foodDrink['quantity'] , 2)}}</td>
                            </tr>
                            @php
                                $total += ($foodDrink['price'] *$foodDrink['quantity']);
                            @endphp
                        @endforeach
                        @endisset
                        <tr><td colspan="3"><hr></td></tr>
                            @if (session('discountValue'))
                            @php
                                $discountAmount = $total * session('discountValue');
                                $total -= $discountAmount;
                            @endphp
                            <tr>
                                <td>Promotion:</td>
                                <td>{{ number_format(session('discountValue') *100, 2) }}%</td>
                                <td>- RM{{number_format( $discountAmount, 2)}}</td>
                            </tr>
                            @else
                                <tr>
                                    <td>Promotion:</td>
                                    <td>0%</td>
                                    <td>- RM{{number_format(0 , 2)}}</td>
                                </tr>
                            @endif

                            <tr>
                                <td colspan="2">Total:</td>
                                <td>RM{{number_format($total , 2)}}</td>
                            </tr>
                            <form action="{{ route('payment.process') }}" method="POST">
                                @csrf
                                
                                <!-- Promo Code Section -->
                                <tr class="promo">
                                    <td>Promo Code:</td>
                                    <td><input type="text" id="promoCode" name="promoCode" placeholder="Enter promo code"></td>
                                    <td><button type="submit" name="action" value="applyPromo">Apply</button></td>
                                </tr>

                                @if (session('status'))
                                <tr>
                                    <td colspan="3">
                                        <div class="alert alert-success">
                                            {{ session('status') }}
                                        </div>
                                    </td>
                                </tr>
                                @endif
                            
                                <!-- Payment Method Section -->
                                <tr><th colspan="3" class="payment-method-header">Payment method</th></tr>
                                <tr>
                                    <td class="payment-options" colspan="3">
                                        <input type="radio" id="paypal" name="payment" value="paypal" checked>
                                        <label for="paypal">
                                            <img src="{{asset('image/paypal-logo.png')}}" alt="PayPal">
                                        </label>
                                        <input type="radio" id="mastercard" name="payment" value="mastercard">
                                        <label for="mastercard">
                                            <img src="{{asset('image/master-logo.png')}}" alt="Mastercard">
                                        </label>
                                        <input type="radio" id="visa" name="payment" value="visa">
                                        <label for="visa">
                                            <img src="{{asset('image/visa-logo.png')}}" alt="Visa">
                                        </label>
                                        <input type="radio" id="bank" name="payment" value="bank">
                                        <label for="bank">
                                            <img src="{{asset('image/bank-transfer-logo.png')}}" alt="Bank Transfer">
                                        </label>
                                    </td>
                                </tr>
                                
                                <!-- Checkout Button -->
                                <tr><td colspan="3" class="modal-footer">
                                    <button class="checkoutBtn" type="submit" name="action" value="checkout">Checkout</button>
                                </td></tr>
                                <input type="hidden" id="amount" name="amount" value="{{$total}}">
                            </form>
                    </table>
                </div>
                         
                
            </div>
        </diV>
        </div>
    </body>
    
</html>
