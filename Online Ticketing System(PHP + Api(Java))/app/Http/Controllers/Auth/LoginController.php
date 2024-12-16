<?php

namespace App\Http\Controllers\Auth;
use App\Models\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers;

class LoginController extends Controller
{
    public function login()
    {
        return view('page/login');
    }
    public function logout(Request $request)
    {
        // Log out the user
        Auth::logout();

        // Invalidate the session and regenerate the token
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        // Redirect to the login page
        return redirect()->route('login');
    }
    
    public function loginPost(Request $request) {
        // Get the credentials (email and password) from the request
        $credentials = [
            'email' => $request->get('email'),
            'password' => $request->get('password'),
        ];
        $remember = $request->has('remember');

        // Attempt to log the user in with the credentials
        if (Auth::attempt($credentials, $remember)) {
            $request->session()->put('email', $credentials['email']);
            return redirect()->route('myticket');
        }
        return redirect('login')->with("error", "Login failed");
    }

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = '/home';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
        $this->middleware('auth')->only('logout');
    }
}
