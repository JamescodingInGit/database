<?php


use App\Http\Controllers\ProfileController;
use App\Http\Controllers\FoodDrinkController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\MoviesController;
use App\Http\Controllers\PayPalController;
use App\Http\Controllers\PaymentController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/
Route::get('/login', [App\Http\Controllers\Auth\LoginController::class, 'login'])->name('login');
Route::post('/login', [App\Http\Controllers\Auth\LoginController::class, 'loginPost'])->name('login.post');
Route::get('/register', [App\Http\Controllers\Auth\RegisterController::class, 'register'])->name('register');
Route::post('/register', [App\Http\Controllers\Auth\RegisterController::class, 'registerPost'])->name('register.post');
Route::post('/logout', [App\Http\Controllers\Auth\LoginController::class, 'logout'])->name('logout');

Route::get('/forgot-password', [App\Http\Controllers\Auth\ForgotPasswordController::class, 'forgotPassword'])->name('forgot.password');
Route::post('forgot-password', [App\Http\Controllers\Auth\ForgotPasswordController::class, 'forgotPasswordPost'])->name('forgot.Password.post');
Route::get('/reset-password/{token}', [App\Http\Controllers\Auth\ForgotPasswordController::class, 'resetPassword'])->name('reset.password');
Route::post('/reset-password', [App\Http\Controllers\Auth\ForgotPasswordController::class, "resetPasswordPost"])->name("reset.password.post");
Route::post('/reset-password/{token}', [App\Http\Controllers\Auth\ForgotPasswordController::class, 'resetPassword'])->name('reset.password');


// Protected routes
Route::middleware('auth')->group(function () {
    Route::get('/myticket', [App\Http\Controllers\profileController::class, 'myticket'])->name('myticket');
    Route::get('/viewOrder/{orderNo}', [App\Http\Controllers\profileController::class, 'viewOrder'])->name('viewOrder');
//    Route::get('/viewOrder/{orderNo}/orderDetails', [App\Http\Controllers\profileController::class, 'viewOrder'])->name('viewOrder');
    
    Route::get('/editProfile', [App\Http\Controllers\profileController::class, 'editProfile'])->name('editProfile');
    Route::post('/editProfile', [App\Http\Controllers\profileController::class, 'editProfilePost'])->name('editProfile.post');
    
    Route::get('/changePass', [App\Http\Controllers\profileController::class, 'changePass'])->name('changePass');
    Route::post('/changePass', [App\Http\Controllers\profileController::class, 'changePassEdit'])->name('changePass.edit');
    Route::post('/changePass/{userID}', [App\Http\Controllers\profileController::class, 'destroyUser'])->name('profile.destroyUser');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::resource('cinemas', 'App\Http\Controllers\CinemaController');

Route::get('/cinema_view', function () {
    return view('cinema');  // Refers to resources/views/myview.blade.php
});


require __DIR__.'/auth.php';

Route::get('/', [HomeController::class, 'showHome']);
Route::get('/movie/imageHorizontal/{id}', [MoviesController::class, 'showImageHorizontal'])->name('movie.imageHorizontal');
Route::get('/movie/imageVertical/{id}', [MoviesController::class, 'showImageVertical'])->name('movie.imageVertical');
Route::get('/details/{id}', [HomeController::class, 'redirect'])->name('home.showMovieDetails');
Route::get('/details/{title}/{date}/{location}', [MoviesController::class, 'showMovieDetails'])->name('movie.showMovieDetails');
Route::get('/seat/{id}', [MoviesController::class, 'showSeat'])->name('movie.showMovieSeat');
Route::post('/seat/{id}/add-cart', [MoviesController::class, 'addSeatCart'])->name('movie.addSeatCart');
Route::get('/foodDrink', [FoodDrinkController::class, 'showCartFoodDrink'])->name('foodDrink.showCartFoodDrink');
Route::post('/foodDrink/add-cart', [FoodDrinkController::class, 'addFoodDrinkCart'])->name('foodDrink.addFoodDrinkCart');
Route::get('/foodDrink/remove-cart/{id}', [FoodDrinkController::class, 'removeFoodDrinkCart'])->name('foodDrink.removeFoodDrinkCart');
Route::get('/food-image/{id}', [FoodDrinkController::class, 'getImage'])->name('food.image');
Route::get('/checkout', [PaymentController::class, 'showCheckOut'])->name('payment.checkout');
Route::post('/checkout/process', [PaymentController::class, 'paymentProcess'])->name('payment.process');
Route::get('/checkout/process-transaction', [PayPalController::class, 'processTransaction'])->name('processTransaction');
Route::get('success-transaction', [PayPalController::class, 'successTransaction'])->name('successTransaction');
Route::get('cancel-transaction', [PayPalController::class, 'cancelTransaction'])->name('cancelTransaction');
