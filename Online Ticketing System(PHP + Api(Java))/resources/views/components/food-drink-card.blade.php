<link rel="stylesheet" href="{{asset('css/foodDrinkCard.css')}}">
<div class="foodDrink-card" onclick="openFoodModal('{{ $foodDrink['price'] }}', '{{ $foodDrink['foodDrinkName'] }}', '{{ $foodDrink['foodDrinkID'] }}')">
  <img class="foodDrinkIMG" src="{{ route('food.image', ['id' => $foodDrink['foodDrinkID']]) }}" alt="Avatar">
  <div class="container">
    <h3>{{$foodDrink['foodDrinkName']}}</h3>
  </div>
</div>