<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="{{ asset('forgotPass.css') }}"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        button[disabled] {
            opacity: 0.5;
            cursor: not-allowed;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="left">
            <div class="form-container">
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
                <a href="{{ route('login') }}"><i class="fa-solid fa-chevron-left"></i></a>
                <h2>Forgot Password</h2>
                <p>Insert your email to renew your password</p>
                <form method="post" action="{{route("forgot.Password.post")}}" id="forgotForm">
                    @csrf
                    <label>Email Address</label>
                    <div class="input-box">
                        <i class="fa-regular fa-envelope"></i>
                        <input type="email" name="email" placeholder="Enter your email" required>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" id="submitBtn" disabled>Next</button>
                </form>
            </div>
        </div>
        <div class="right"></div>
    </div>
</body>

<script>
const emailField = document.querySelector('input[name="email"]');

// Validate email using built-in HTML5 email type
function validateEmail() {
    return emailField.checkValidity();
}

// Function to validate all form fields and enable/disable the submit button accordingly
function checkFormValidity() {
    const isEmailValid = validateEmail();

    // Enable the submit button only if all validations pass
    submitBtn.disabled = !(isEmailValid);
}


// Email Validation
function validateEmail() {
    const emailField = document.querySelector('input[name="email"]');
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Simple email validation regex
    return emailRegex.test(emailField.value);
}

document.querySelector('input[name="email"]').addEventListener('input', checkFormValidity);

// Prevent form submission if the submit button is disabled
document.getElementById("forgotForm").addEventListener("submit", function (event) {
    if (submitBtn.disabled) {
        event.preventDefault();
    }
});


    
</script>

</html>