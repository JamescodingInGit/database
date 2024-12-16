<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="{{ asset('css/login.css') }}"/>
    <style>
    </style>
</head>
@if($errors->any())
    <script>
        @foreach($errors->all() as $error)
            alert("{{ $error }}");
        @endforeach
    </script>
@endif

        @if(session()->has("success"))
        <script>
                    alert("{{ session()->get('success') }}");
        </script>
        @endif

        @if(session()->has("error"))
        <script>
            alert("{{ session()->get('error') }}");
        </script>
        @endif
<body>
    <nav>
        <a href="#"><img src="{{ asset('image/tgv-logo.png') }}" alt="logo"></a>
    </nav>
    <div class="form-wrapper">
        <h2>Sign In</h2>
        <!-- Login form -->
        <form method="POST" action="{{route("login.post")}}">
            @csrf
            <div class="form-control">
                <input type="text" name="email" required>
                <label>Email</label>
            </div>
            <div class="form-control">
                <input type="password" name="password" required>
                <label>Password</label>
            </div>
            <button type="submit">Sign In</button>
            <div class="form-help"> 
                <div class="remember-me">
                    <input type="checkbox" id="remember-me" name="remember">
                    <label for="remember-me">Remember me</label>
                </div>
                <a href="{{ route('forgot.password') }}">Forgot Password?</a>
            </div>
        </form>

        <p>New to the site? <a href="{{ route('register') }}">Sign up now</a></p>
    </div>
</body>
</html>
