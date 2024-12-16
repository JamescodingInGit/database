<?php

namespace App\Http\Controllers;

use App\Models\ShowtimeDetails;
use App\Models\Movie;
use App\Models\Promotion;
use Illuminate\Support\Facades\Session;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    public function showCheckOut()
    {

        $tickets = json_decode(Session::get('ticket'), true); 
        $showID = Session::get('showID');
        $seats =  Session::get('seats');
        $foodDrinks = Session::get('foodDrinks', []);


        $showTime = ShowtimeDetails::where('showID', $showID)->first();
        $movie = Movie::where('movieID',$showTime->movieID)->first();

        return view('page/checkout',compact('tickets','seats','showTime', 'foodDrinks', 'movie'));
    }

    public function paymentProcess(Request $request){
        $action = $request->input('action');
        $showID = Session::get('showID');
        $showTime = ShowtimeDetails::where('showID', $showID)->first();
        $paymentMethod = $request->input('payment');
        $amount = $request->input('amount');
        $currentDate = now();
    
        if ($action === 'applyPromo') {
            $promoCode = $request->input('promoCode');
            $promotion = Promotion::where('promotionCode',$promoCode)->first();
            if($promotion == null){
                return redirect()->back()->with('status', 'Invalid promo code!');
            }
            else if($showTime->movieID != $promotion->movieID && $promotion->movieID!=null){
                return redirect()->back()->with('status', 'Invalid promo code on this movie!');
            }
            else if($promotion->paymentRequired != $paymentMethod){
                return redirect()->back()->with('status', 'Invalid promo code on this payment method!');
            }
            else if($promotion->movieExperienceRequired != $showTime->movieExperience){
                return redirect()->back()->with('status', 'Invalid promo code on this movie experience!');
            }
            else if ($currentDate < $promotion->promotionStartDate || $currentDate > $promotion->promotionEndDate) {
                return redirect()->back()->with('status', 'Promo code is not valid for the current date!');
            }
            $discountValue = $promotion->promotionValue; 
    
            return redirect()->back()->with('status', 'Promo code applied successfully!')->with('discountValue', $discountValue);
        }
        
        if ($action === 'checkout') {
            
            if($paymentMethod == 'paypal'){
                return redirect()->route('processTransaction', ['amount' => $amount]);
            }
        }
        
        return redirect()->back()->with('error', 'Invalid action');
    }
}
