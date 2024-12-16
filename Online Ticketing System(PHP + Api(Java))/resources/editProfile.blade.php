<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="{{asset('edit.css')}}"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
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
    <header class="navbar">
        <a href="#"><img src="{{asset('logo.svg')}}" alt="logo"></a>
        <div class="Edit Profile">
            <span class="profile-name">{{$user->name}}</span>
        </div>
    </header>

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
            <h3 class="name">{{$user->name}}</h3>
            <p class="email"><i class="fa-regular fa-envelope"></i>{{$user->email}}</p>
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
            <h3>My Profile</h3>
            <form method="POST" action="{{route("editProfile.post")}}">
                @csrf
                <label>Full Name</label>
                <div class="input-box">
                    <i class="fa-solid fa-user"></i>
                    <input type="text" name="name" value="{{ old('name', $user->name) }}" placeholder="Enter your name" required>
                </div>
                <label>Mobile Number</label>
                <div class="input-box">
                    <i class="fa-solid fa-phone"></i>
                    <input type="tel" id="phone" name="mobileNo" value="{{ old('mobileNo', $user->mobileNo) }}" placeholder="011-12345678"
                        pattern="(01[0-9]{1})-?[0-9]{7,8}" required>
                </div>
                <label>Email Address</label>
                <div class="input-box">
                    <i class="fa-regular fa-envelope"></i>
                    <input type="email" name="email" value="{{ old('email', $user->email) }}" placeholder="Enter your email" required>
                </div>
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
                <button id="updateBtn" type="submit">Update</button>
            </form>

        </div>
    </div>
</body>
<script>
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