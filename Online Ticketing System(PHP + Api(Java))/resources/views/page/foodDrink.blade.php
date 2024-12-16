<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>TGV</title>
        <link rel="stylesheet" href="{{asset('css/foodDrink.css')}}">
        <link rel="stylesheet" href="{{asset('css/progress.css')}}">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="{{asset('js/foodDrink.js')}}"></script>
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
                <div class="stepper-item active">
                    <div class="step-counter">3</div>
                    <div class="step-name">Checkout & Payment</div>
                </div>
            </div>
            <button class="close-button">&times;</button> <!-- Close button -->
        </nav>
        <div class="foodDrink-container">
            <div class="foodDrink" style="background: url(foodDrink.png)">
                <div class="foodDrinkGradientBtt"></div>
            </div>
        </div>
        <div class="foodDrinkNavbar">
            <a href="#" class="foodDrinkNavBarActive" onclick="foodSelect('alaCarteFood')">ALA CARTE FOOD</a>
            <a href="#" onclick="foodSelect('alaCarteDrinks')">ALA CARTE DRINKS</a>
        </div>

        <div class="foodContainer alaCarteFood">
            @foreach ($foods as $food )
                <x-food-drink-card :data="$food" ></x-food-drink-card>
            @endforeach
        </div>

        <div class="foodContainer alaCarteDrinks">
            @foreach ($drinks as $drink )
                <x-food-drink-card :data="$drink" ></x-food-drink-card>
            @endforeach
        </div>

        <div class="booking-container">
            <button class="book-button" onclick="openCartModal()">View Cart</button>
        </div>

        <form action="{{ route('foodDrink.addFoodDrinkCart', ['id' => $showTime['showID']]) }}" method="POST">
            @csrf
            <div id="foodModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Select Food/Drink</h2>
                        <span class="modal-close" onclick="closeFoodModal()">&times;</span>
                    </div>
                    <div class="modal-body">
                        <div class="foodDrink-row">
                            <img id="foodImage" src="popcorn.jpg" alt="foodDrink">
                            <div class="foodDrinkDetail">
                                <h3 id="foodName">Name</h3>
                                <p id="foodPrice">Price</p>
                                <div class="foodDrink-selector">
                                    <button type="button" id="minus-button" onclick="updateFoodDrinkCount(-1)">-</button>
                                    <input type="number" class="ticket-input" id="foodQuantity" name="foodQuantity" min="0" step="1" value="0" readonly>
                                    <button type="button" id="plus-button" onclick="updateFoodDrinkCount(1)">+</button>
                                    <input type="hidden" name="foodDrinkID" id="hiddenFoodDrinkID">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit">Add To Cart</button>
                    </div>
                </div>
            </div>
        </form>
        
        
        <div id="cartModal" class="modal">
            <diV class="modal-all">
            <div class="modal-content">
                <div class="cart-header">
                    <span class="cart-icon">
                      <i class="fa fa-shopping-cart"></i>
                    </span>
                    <span class="cart-title">Cart Details</span>
                    <span class="cart-arrow" onclick="closeCartModal()">
                      <i class="fa fa-chevron-down"></i>
                    </span>
                  </div>
                
                  <div class="movie-info">
                    <h2 class="movie-title">{{$movie['movieTitle']}}</h2>
                    <div class="movie-location">
                      <span class="location-icon"><i class="fa fa-map-marker"></i> {{$showTime['cinemaName']}}</span>
                      <span class="cinema-icon"><i class="fa fa-film"></i> Cinema {{$showTime['hallID']}}</span>
                    </div>
                    <div class="movie-details">
                      <span class="date-icon"><i class="fa fa-calendar"></i> {{ \Carbon\Carbon::parse($showTime['movieDateTime'])->format('d M Y, g:i A') }}</span>
                      <span class="seat-icon"><i class="fa fa-ticket"></i>{{$seats}}</span>
                    </div>
                  </div>
                <div class="modal-body">
                    <table>
                        <tr>
                            <th colspan="3" style="text-align: left">Seats</th>
                        </tr>
                        @foreach ($tickets as $ticket )
                            <tr>
                                <td style="width:70%">{{$ticket['type']}}<br>RM{{number_format($ticket['price'], 2)}}</td>
                                <td style="width:20%">{{$ticket['quantity']}}</td>
                                <td style="width:10%">RM{{number_format($ticket['price'] *$ticket['quantity'] , 2)}}</td>
                            </tr>
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
                                    <td style="width:70%">{{$foodDrink['foodDrinkName']}}<br>RM{{number_format($foodDrink['price']  , 2)}}
                                        <br><span class="editBtn">Edit</span> <a href="{{ url('foodDrink/remove-cart/' . $foodDrink['foodDrinkID']) }}" class="editBtn">Remove</a></td>
                                    <td style="width:20%">{{$foodDrink['quantity']}}</td>
                                    <td style="width:10%">RM{{number_format($foodDrink['price'] *$foodDrink['quantity'] , 2)}}</td>
                                </tr>
                            @endforeach
                        @endisset
                    </table>
                </div>
                <div class="modal-footer">
                    <a href="{{ url('checkout/') }}">Checkout</a>
                </div>
            </div>
        </diV>
        </div>

        <script>
            navBar();
            foodActive();
          </script>
    </body>
    
</html>
