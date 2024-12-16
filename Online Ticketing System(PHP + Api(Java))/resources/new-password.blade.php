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
        .error-message {
            color: red;
            font-size: 14px;
            display: none;
            margin-top: 5px;
        }
    </style>
</head>

<body>
    <div class="container">
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
        <div class="left">
            <div class="form-container">
                <a href="{{ route('login') }}"><i class="fa-solid fa-chevron-left"></i></a>
                <h2>Forgot Password</h2>
                <p>Insert your email to renew your password</p>
                <form method="post" action="{{route("reset.password.post")}}" id="forgotForm">
                    @csrf
                    <input type="text" name="token" hidden value="{{$token}}">

                    <label>Email Address</label>
                    <div class="input-box">
                        <i class="fa-regular fa-envelope"></i>
                        <input type="email" name="email" placeholder="Enter your email" required>
                    </div>
                    <span id="emailError" class="error-message">Invalid email format</span>

                    <label>Enter New Password</label>
                    <div class="input-box">
                        <i class="fa-solid fa-eye-slash" id="togglePassword1"></i>
                        <input type="password" name="password" placeholder="Enter new password" id="newPass" required>
                    </div>

                    <label>Confirm Password</label>
                    <div class="input-box">
                        <i class="fa-solid fa-eye-slash" id="togglePassword2"></i>
                        <input type="password" name="password_confirmation" placeholder="Retype your password" id="reNewPass" required>
                    </div>
                    <span id="passwordError" class="error-message">Passwords do not match</span>

                    <!-- Submit Button -->
                    <button type="submit" id="submitBtn" disabled>Submit</button>
                </form>
            </div>
        </div>
        <div class="right"></div>
    </div>
</body>

<script>
    const passwordField1 = document.getElementById("newPass");
    const togglePassword1 = document.getElementById("togglePassword1");
    const passwordField2 = document.getElementById("reNewPass");
    const togglePassword2 = document.getElementById("togglePassword2");
    const emailField = document.querySelector('input[name="email"]');
    const submitBtn = document.getElementById("submitBtn");

    const emailError = document.getElementById("emailError");
    const passwordError = document.getElementById("passwordError");

    // Email validation using regex
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    function validateEmail() {
        return emailRegex.test(emailField.value);
    }

    function checkPasswords() {
        const newPass = passwordField1.value;
        const reNewPass = passwordField2.value;
        return newPass === reNewPass;
    }

    // Function to validate form and enable/disable the submit button
    function checkFormValidity() {
        const isEmailValid = validateEmail();
        const arePasswordsMatching = checkPasswords();
        const areFieldsFilled = emailField.value && passwordField1.value && passwordField2.value;

        if (!isEmailValid) {
            emailError.style.display = "block";
        } else {
            emailError.style.display = "none";
        }

        if (!arePasswordsMatching) {
            passwordError.style.display = "block";
        } else {
            passwordError.style.display = "none";
        }

        // Enable the submit button only if all validations pass
        submitBtn.disabled = !(isEmailValid && arePasswordsMatching && areFieldsFilled);
    }

    // Add input event listeners for form validation
    emailField.addEventListener('input', checkFormValidity);
    passwordField1.addEventListener('input', checkFormValidity);
    passwordField2.addEventListener('input', checkFormValidity);

    // Toggle visibility for password fields
    togglePassword1.addEventListener("click", function () {
        const type = passwordField1.getAttribute("type") === "password" ? "text" : "password";
        passwordField1.setAttribute("type", type);
        this.classList.toggle("fa-eye");
        this.classList.toggle("fa-eye-slash");
    });

    togglePassword2.addEventListener("click", function () {
        const type = passwordField2.getAttribute("type") === "password" ? "text" : "password";
        passwordField2.setAttribute("type", type);
        this.classList.toggle("fa-eye");
        this.classList.toggle("fa-eye-slash");
    });
</script>

</html>
