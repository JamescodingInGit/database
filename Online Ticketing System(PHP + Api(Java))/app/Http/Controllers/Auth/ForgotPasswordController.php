<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use App\Models\User;


class ForgotPasswordController extends Controller
{
    public function forgotPassword()
    {
        return view('forgot-password');
    }
    
    public function forgotPasswordPost(Request $request) {
        $request->validate([
            'email' => 'required|email|exists:users,email', // Correct
        ]);

        $token = Str::random(64);
        
        DB::table('password_resets')->insert([
            'email' => $request->email,
            'token' => $token,
            'created_at' => Carbon::now()
        ]);
        
        Mail::send("email-forgot-password", ['token' => $token], function ($message) use ($request){
            $message->to($request->email);
            $message->subject("Reset Password");
        });
        
        return redirect()->to(route("forgot.password"))->with("success", "we have send an email to reset password.");

    }
    
    function resetPassword($token) {
        return view("new-password", compact('token'));
    }
    
    function resetPasswordPost(Request $request) {
        $request->validate([
            'email' => 'required|email|exists:Users',
            "password" => 'required|string|min:6|confirmed',
            "password_confirmation" => "required"
        ]);
        
        $updatePassword = DB::table('password_resets')
                ->where([
                    'email' => $request->email,
                    'token' => $request->token
                ])->first();
        
        if(!$updatePassword){
            return redirect()->to(route(reset.password))->with("error", "Invalid");
        }
        
        User::where("email", $request->email)->Update(["password" => bcrypt($request->password)]);
        
        DB::table('password_resets')->where(["email" => $request->email])->delete();
        
        return redirect()->to(route("login"))->with("success", "Password reset success");
    }

    use SendsPasswordResetEmails;
}
