<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Foundation\Auth\RegistersUsers;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class RegisterController extends Controller
{

    
    public function register()
    {
        return view('register');
    }
    public function registerPost(Request $request)
    {
//        $request->validate([
//            "name" => "required",
//            "mobileNo" => "required",
//            "email" => "required",
//            "password" => "required",
//            "gender" => "required",
//            "DOB" => "required",
//            "state" => "required",
//            "district" => "required",
//        ]);
        $user = new User();
        $user->name = $request->get('name');
        $user->mobileNo = $request->get('mobileNo');
        $user->email = $request->get('email');
        $user->password = $request->get('password');
        $user->gender = $request->get('gender');
        $user->DOB = $request->get('dob');
        $user->state = $request->get('state');
        $user->district = $request->get('district');
        if($user->save()){
            return redirect(route("login"))->with("success", "User created successfully");
        }
        return redirect(route("register"))->with("error", "Failed to create account");
    }
    /**
     * Where to redirect users after registration.
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
        $this->middleware('guest');
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return \App\Models\User
     */
    protected function create(array $data)
    {
        return User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
        ]);
    }
}
