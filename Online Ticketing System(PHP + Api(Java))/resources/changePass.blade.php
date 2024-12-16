<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <link rel="stylesheet" href="{{asset('changePass.css')}}">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.1/dist/flowbite.min.js"></script>
        <style>
            .error-message {
                color: red;
                font-size: 0.9rem;
                display: none; /* Initially hidden */
            }

            button[disabled] {
                opacity: 0.5;
                cursor: not-allowed;
            }
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                background-color: rgba(0, 0, 0, 0.5); /* Black background with opacity */
            }

            .modal-content {
                background-color: white;
                margin: 15% auto; /* 15% from the top and centered */
                padding: 20px;
                border-radius: 8px;
                width: 80%;
                max-width: 500px;
                text-align: center;
            }

            .modal h2 {
                color: #111;
                font-size: 1.2rem;
                margin-bottom: 10px;
            }

            .modal p {
                color: #111;
                font-size: 1rem;
                margin-bottom: 20px;
            }

            .modal-buttons {
                display: flex;
                justify-content: space-between;
                gap: 5px; /* Space between buttons */
            }

            .modal-buttons .btn {
                flex: 1; /* Each button takes up equal space */
                padding: 10px;
                font-size: 1rem;
                cursor: pointer;
                border: none;
                border-radius: 5px;
            }

            .cancel-btn {
                background-color: #ccc;
                color: #333;
                margin-right: 2px; /* Adjust spacing to ensure there's no extra gap */
            }

            .confirm-btn {
                background-color: #d9534f;
                color: white;
                margin-left: 2px; /* Adjust spacing to ensure there's no extra gap */
            }

            .modal-buttons .btn:hover {
                opacity: 0.8;
            }
        </style>
    </head>

    <body>
        <header class="navbar">
            <a href="#"><img src="{{asset('logo.svg')}}" alt="logo"></a>
            <div class="Edit Profile">
                <span class="profile-name">{{ $user->name }}</span>
            </div>
        </header>
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

        <div class="container">
            <div class="name-card">
                <div class="icon">
                    <div class="name-icon">
                        @php
                        // Split the name into parts
                        $parts = explode(' ', $user->name);

                        /// Initialize the initials
                        $initials = '';

                        // Take the first letter of each of the first two parts
                        for ($i = 0; $i < min(2, count($parts)); $i++) {
                        if (strlen($parts[$i]) > 0) {
                        $initials .= strtoupper($parts[$i][0]);
                        }
                        }
                        @endphp
                        {{ $initials }}
                    </div>
                </div>
                <h3 class="name">{{ $user->name }}</h3>
                <p class="email"><i class="fa-regular fa-envelope"></i> {{$user->email}}</p>
                <p class="phone"><i class="fa-solid fa-phone"></i> {{$user->mobileNo}}</p>
                <div class="edit-btn">
                    <a href="{{route('editProfile')}}" class="btn btn-primary">Edit Profile</a>
                </div>
                <div class="info">
                    <div class="menu-item">
                        <span><a href="{{route('myticket')}}"/>My Tickets</a></span>
                        <i class="fas fa-angle-right"></i>
                    </div>
                    <div class="menu-item">
                        <span><a href="{{route('changePass')}}"/>Change Password</a></span>
                        <i class="fas fa-angle-right"></i>
                    </div>
                    <div class="menu-item">
                        <button id="deleteAccountBtn" class="delete-btn">
                            <span>Delete Account</span>
                            <i class="fas fa-angle-right"></i>
                        </button>
                    </div>

                    <!-- Modal -->
                    <div id="deleteAccountModal" class="modal">
                        <div class="modal-content">
                            <form id="deleteAccountForm" action="{{ route('profile.destroyUser', ['userID' => $user->userID]) }}" method="POST">
                                @csrf
                                <h2><strong>Important: Confirm Your Account Deletion</strong></h2>
                                <p style="margin-bottom: 10px;">
                                    We're sad to see you leave! Please confirm if you wish to delete your account. Remember, this action is
                                    irreversible and will permanently erase all your account data, preferences, and accumulated rewards.
                                </p>
                                <div class="modal-buttons">
                                    <button type="button" id="cancelBtn" class="btn cancel-btn">Cancel</button>
                                    <button type="submit" id="confirmBtn" class="btn confirm-btn">Confirm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="menu-item">
                        <form action="{{ route('logout') }}" method="POST">
                            @csrf
                            <button type="submit" class="logout-btn">
                                <span>Logout</span>
                                <i class="fa-solid fa-right-from-bracket"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="ticket-card">
                <h3>Change Password</h3>
                <form id="changePassForm" action="{{route("changePass.edit")}}" method="POST">
                    @csrf
                    <label>Current Password</label>
                    <div class="input-box">
                        <input type="password" id="password" placeholder="Enter your current password" name="password" required>
                        <i class="fa-solid fa-eye-slash" id="togglePassword"></i>
                    </div>
                    <label>New Password</label>
                    <div class="input-box">
                        <input type="password" id="newPass" placeholder="Enter your new password" name="newPass" required>
                        <i class="fa-solid fa-eye-slash" id="togglePassword1"></i>
                    </div>
                    <label>Re-type Password</label>
                    <div class="input-box">
                        <input type="password" id="reNewPass" placeholder="Re-enter your new password" required>
                        <i class="fa-solid fa-eye-slash" id="togglePassword2"></i>
                    </div>
                    <p class="error-message" id="errorMsg">Passwords do not match</p>
                    <button type="submit" id="submitBtn" disabled>Update</button>
                </form>

            </div>
        </div>
    </body>
    <script>
        const passwordField = document.getElementById("password");
        const togglePassword = document.getElementById("togglePassword");
        const passwordField1 = document.getElementById("newPass");
        const togglePassword1 = document.getElementById("togglePassword1");
        const passwordField2 = document.getElementById("reNewPass");
        const togglePassword2 = document.getElementById("togglePassword2");
        const errorMsg = document.getElementById("errorMsg");
        const submitBtn = document.getElementById("submitBtn");

        // Password toggle logic
        togglePassword.addEventListener("click", function () {
            const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
            passwordField.setAttribute("type", type);
            this.classList.toggle("fa-eye");
            this.classList.toggle("fa-eye-slash");
        });

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

        // Real-time password matching check
        function checkPasswords() {
            const newPass = passwordField1.value;
            const reNewPass = passwordField2.value;

            if (newPass !== reNewPass) {
                errorMsg.style.display = "block";  // Show error message
                submitBtn.disabled = true;  // Disable the submit button
            } else {
                errorMsg.style.display = "none";  // Hide error message
                submitBtn.disabled = false;  // Enable the submit button
            }
        }

        // Listen to input events to check password match in real-time
        passwordField1.addEventListener('input', checkPasswords);
        passwordField2.addEventListener('input', checkPasswords);

        document.addEventListener('DOMContentLoaded', function () {
            // Get the modal and the buttons
            const deleteAccountBtn = document.getElementById('deleteAccountBtn');
            const deleteAccountModal = document.getElementById('deleteAccountModal');
            const cancelBtn = document.getElementById('cancelBtn');
            const confirmBtn = document.getElementById('confirmBtn');

            // Show the modal when "Delete Account" button is clicked
            deleteAccountBtn.addEventListener('click', function () {
                deleteAccountModal.style.display = 'block';
            });

            // Hide the modal when "Cancel" button is clicked
            cancelBtn.addEventListener('click', function () {
                deleteAccountModal.style.display = 'none';
            });

            // Hide the modal and confirm action when "Confirm" button is clicked
            confirmBtn.addEventListener('click', function () {
                // You can add your account deletion logic here
                alert('Account deleted successfully!');
                deleteAccountModal.style.display = 'none';
            });

            // Hide the modal if clicked outside the modal content
            window.addEventListener('click', function (event) {
                if (event.target == deleteAccountModal) {
                    deleteAccountModal.style.display = 'none';
                }
            });
        });
    </script>

</html>
