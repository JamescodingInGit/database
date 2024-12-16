<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <link rel="stylesheet" href="{{asset('register.css')}}">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <style>
            .error-message {
                color: red;
                font-size: 0.9rem;
                display: none;
                /* Initially hidden */
            }

            button[disabled] {
                opacity: 0.5;
                cursor: not-allowed;
            }
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
        <div class="container">
            <nav>
                <a href="#"><img src="{{asset('logo.svg')}}" alt="logo"></a>
            </nav>
            <div class="left">
                <div class="form-container">
                    <h2>Sign Up</h2>
                    <div class="log-text">Already have an account? <a href="{{ route('login') }}">Login now</a></div>
                    <form method="post" action="{{route('register.post')}}">
                        @csrf
                        <!-- Name Input -->
                        <label>Full Name</label>
                        <div class="input-box">
                            <input type="text" name="name" id="fullName" placeholder="Enter your name" minlength="5" required autofocus>
                        </div>
                        <p class="error-message" id="nameError">Name must be at least 5 characters and contain no special
                            characters.</p>

                        <!-- Mobile Number Input -->
                        <label>Mobile Number</label>
                        <div class="input-box">
                            <i class="fa-solid fa-phone"></i>
                            <input type="tel" id="phone" name="mobileNo" placeholder="011-12345678"
                                   pattern="(01[0-9]{1})-?[0-9]{7,8}" required>
                        </div>

                        <!-- Email Input -->
                        <label>Email Address</label>
                        <div class="input-box">
                            <i class="fa-regular fa-envelope"></i>
                            <input type="email" name="email" placeholder="Enter your email" required>
                        </div>

                        <!-- Gender Input -->
                        <label>Gender</label>
                        <div class="input-box radio-group">
                            <label class="cont-check">Male(M)
                                <input type="radio" value="Male" checked="checked" name="gender">
                                <span class="checkmark"></span>
                            </label>
                            <label class="cont-check">Female(F)
                                <input type="radio" value="Female" name="gender">
                                <span class="checkmark"></span>
                            </label>
                        </div>

                        <!-- Password Input -->
                        <label>Password</label>
                        <div class="input-box">
                            <input type="password" name="password" id="password" placeholder="Enter your password" required>
                            <i class="fa-solid fa-eye-slash" id="togglePassword"></i>
                        </div>
                        <p class="error-message" id="passwordError">Password must be 6 characters long, contain at least one
                            number, one uppercase and lowercase letter.</p>

                        <label>Date of Birth</label>
                        <div class="input-box">
                            <input class="date" type="date" name="dob" required>
                        </div>

                        <label for="state">State</label>
                        <div class="input-box" id="state" required>
                            <select name="state">
                                <option value="" hidden>Select state</option> <!-- Hidden in the dropdown -->
                                <option value="Johor">Johor</option>
                                <option value="Kedah">Kedah</option>
                                <option value="Kelantan">Kelantan</option>
                                <option value="Kuala Lumpur">Kuala Lumpur</option>
                                <option value="Labuan">Labuan</option>
                                <option value="Melaka">Melaka</option>
                                <option value="Negeri Sembilan">Negeri Sembilan</option>
                                <option value="Pahang">Pahang</option>
                                <option value="Penang">Penang</option>
                                <option value="Perak">Perak</option>
                                <option value="Perlis">Perlis</option>
                                <option value="Putrajaya">Putrajaya</option>
                                <option value="Sabah">Sabah</option>
                                <option value="Sarawak">Sarawak</option>
                                <option value="Selangor">Selangor</option>
                                <option value="Terengganu">Terengganu</option>
                            </select>
                        </div>

                        <label>District</label>
                        <div class="input-box">
                            <input type="text" name="district" placeholder="Enter your district" required>
                        </div>

                        <!-- Submit Button -->
<!--                        <button type="submit" id="submitBtn" disabled>Sign Up</button>-->
                        <button type="submit" id="submitBtn" disabled>Sign Up</button>
                    </form>
                </div>
            </div>
            <div class="right"></div>
        </div>
    </body>

    <script>
        const passwordField = document.getElementById("password");
        const togglePassword = document.getElementById("togglePassword");
        const nameField = document.getElementById("fullName");
        const nameError = document.getElementById("nameError");
        const passwordError = document.getElementById("passwordError");
        const submitBtn = document.getElementById("submitBtn");
        const phoneField = document.getElementById("phone");
        const emailField = document.querySelector('input[name="email"]');
        const stateField = document.querySelector('select[name="state"]');
        const districtField = document.querySelector('input[name="district"]');

    // Toggle password visibility
        togglePassword.addEventListener("click", function () {
            const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
            passwordField.setAttribute("type", type);
            this.classList.toggle("fa-eye");
            this.classList.toggle("fa-eye-slash");
        });

    // Name Validation (5+ characters, no special characters)
        function validateName() {
            const nameRegex = /^[a-zA-Z ]{5,}$/;  // At least 5 characters, only letters and spaces
            if (!nameRegex.test(nameField.value)) {
                nameError.style.display = "block";
                return false;
            } else {
                nameError.style.display = "none";
                return true;
            }
        }

    // Password Validation (8+ chars, 1 uppercase, 1 lowercase, 1 number)
        function validatePassword() {
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;
            if (!passwordRegex.test(passwordField.value)) {
                passwordError.style.display = "block";
                return false;
            } else {
                passwordError.style.display = "none";
                return true;
            }
        }

    // Validate phone number (using pattern)
        function validatePhone() {
            const phonePattern = /^(01[0-9]{1})-?[0-9]{7,8}$/;
            return phonePattern.test(phoneField.value);
        }

    // Validate email using built-in HTML5 email type
        function validateEmail() {
            return emailField.checkValidity();
        }

    // Validate state selection (not empty)
        function validateState() {
            return stateField.value !== "";
        }

    // Validate district (not empty)
        function validateDistrict() {
            return districtField.value.trim() !== "";
        }

    // Function to validate all form fields and enable/disable the submit button accordingly
        function checkFormValidity() {
            const isNameValid = validateName();
            const isPasswordValid = validatePassword();
            const isEmailValid = validateEmail();
            const isPhoneValid = validatePhone();
            const isDateValid = validateDate();
            const isStateValid = validateState();
            const isDistrictValid = validateDistrict();
            const isGenderSelected = validateGender();

            // Enable the submit button only if all validations pass
            submitBtn.disabled = !(isNameValid && isPasswordValid && isEmailValid && isPhoneValid && isDateValid && isStateValid && isDistrictValid && isGenderSelected);
        }

    // Name Validation (5+ characters, no special characters)
        function validateName() {
            const nameRegex = /^[a-zA-Z ]{5,}$/; // At least 5 characters, only letters and spaces
            if (!nameRegex.test(nameField.value)) {
                nameError.style.display = "block";
                return false;
            } else {
                nameError.style.display = "none";
                return true;
            }
        }

    // Password Validation (8+ chars, 1 uppercase, 1 lowercase, 1 number)
        function validatePassword() {
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
            if (!passwordRegex.test(passwordField.value)) {
                passwordError.style.display = "block";
                return false;
            } else {
                passwordError.style.display = "none";
                return true;
            }
        }

    // Email Validation
        function validateEmail() {
            const emailField = document.querySelector('input[name="email"]');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Simple email validation regex
            return emailRegex.test(emailField.value);
        }

    // Phone Number Validation
        function validatePhone() {
            const phoneField = document.getElementById("phone");
            const phoneRegex = /^01[0-9]{1}-?[0-9]{7,8}$/; // Malaysian phone number validation
            return phoneRegex.test(phoneField.value);
        }

    // Gender Validation (check if one radio button is selected)
        function validateGender() {
            const genderFields = document.querySelectorAll('input[name="gender"]');
            return Array.from(genderFields).some(radio => radio.checked);
        }

    // Date of Birth Validation (check if a date is selected)
        function validateDate() {
            const dateField = document.querySelector('input[type="date"]');
            return dateField.value !== ''; // Check if date is filled
        }

    // State Validation (check if a state is selected)
        function validateState() {
            const stateField = document.querySelector('select[name="state"]');
            return stateField.value !== ''; // Check if a state is selected
        }

    // District Validation (check if district is filled)
        function validateDistrict() {
            const districtField = document.querySelector('input[name="district"]');
            return districtField.value.trim() !== ''; // Ensure the district field is not empty
        }

    // Add event listeners to all fields for real-time validation
        nameField.addEventListener('input', checkFormValidity);
        passwordField.addEventListener('input', checkFormValidity);

        document.querySelector('input[name="email"]').addEventListener('input', checkFormValidity);
        document.getElementById("phone").addEventListener('input', checkFormValidity);
        document.querySelector('input[type="date"]').addEventListener('change', checkFormValidity);
        document.querySelector('select[name="state"]').addEventListener('change', checkFormValidity);
        document.querySelector('input[name="district"]').addEventListener('input', checkFormValidity);

        const genderFields = document.querySelectorAll('input[name="gender"]');
        genderFields.forEach(genderField => genderField.addEventListener('change', checkFormValidity));

    // Prevent form submission if the submit button is disabled
        document.getElementById("registerForm").addEventListener("submit", function (event) {
            if (submitBtn.disabled) {
                event.preventDefault();
            }
        });



    </script>

</html>