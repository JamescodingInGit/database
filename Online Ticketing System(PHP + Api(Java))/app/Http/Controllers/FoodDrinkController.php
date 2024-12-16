<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\FoodDrink;
use App\Models\ShowtimeDetails;
use App\Models\Movie;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Log;
class FoodDrinkController extends Controller
{
    public function showCartFoodDrink(){
        $foods = FoodDrink::where('type', 'food')->get();
        $drinks = FoodDrink::where('type', 'drink')->get();
        $tickets = json_decode(Session::get('ticket'), true); 
        $showID = Session::get('showID');
        $seats =  Session::get('seats');

        $showTime = ShowtimeDetails::where('showID', $showID)->first();
        $movie = Movie::where('movieID',$showTime->movieID)->first();

        return view('page/foodDrink',compact('foods','drinks','tickets','seats','showTime', 'movie'));
    }

    public function addFoodDrinkCart(Request $request)
    {
        $foodDrinks = FoodDrink::all();

        $existingCart = Session::get('foodDrinks', []);
    
        // Iterate through the selected food and drinks
        foreach ($foodDrinks as $foodDrink) {
            $quantity = $request->input($foodDrink['foodDrinkID']);
    
            if (isset($existingCart[$foodDrink['foodDrinkID']]) && $quantity && $quantity <= 0) {
                unset($existingCart[$foodDrink['foodDrinkID']]);    
            }
            elseif (isset($existingCart[$foodDrink['foodDrinkID']]) && $quantity && $quantity > 0){
                $existingCart[$foodDrink->foodDrinkID]['quantity'] += $quantity;
            }
            elseif ($quantity && $quantity > 0) {
                $existingCart[$foodDrink['foodDrinkID']] = [
                    'foodDrinkID' => $foodDrink['foodDrinkID'],
                    'foodDrinkName' => $foodDrink->foodDrinkName,
                    'quantity' => $quantity,
                    'price' => $foodDrink->price
                ];
            }
        }
        Session::put('foodDrinks', $existingCart);

        return redirect()->back();
    }

    public function removeFoodDrinkCart($foodDrinkID)
    {
        $foodDrinks = FoodDrink::all();

        $existingCart = Session::get('foodDrinks', []);
    
        unset($existingCart[$foodDrinkID]);    
        Session::put('foodDrinks', $existingCart);

        return redirect()->back();
    }

    public function getImage($id){
        $foodDrink = FoodDrink::where('foodDrinkID', $id)->first();

        // Retrieve the image data
        $image = $foodDrink->foodDrinkImage; // Assuming this is stored as a binary blob

        // Return the image as a response
        return response($image)->header('Content-Type', 'image/jpeg'); 
    }
    
}
