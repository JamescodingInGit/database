<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <link rel="stylesheet" href="{{asset('myticket.css')}}"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <style>
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
            .no-record {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                color: #999;
                margin-top: 40px;
            }

            .no-record i {
                font-size: 110px; /* Set icon size to 50px */
                margin-bottom: 10px;
                color: rgba(240, 240, 240, 0.5);
            }

            .no-record p {
                color: #aaa;
            }
        </style>
    </head>
    <body>
        <header class="navbar">
            <a href="#"><img src="{{asset('logo.svg')}}" alt="logo"></a>
            <nav>
                <ul>
                    <li><a href="promotion.html">Discount & Promotion</a></li>
                </ul>
            </nav>
            <div class="profile">
                <span class="profile-name">{{ $user->name }}</span>
            </div>
        </header>
        @if($errors->any())
        <script>
            @foreach($errors-> all() as $error)
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
                <h3 class="name">{{$user->name}}</h3>
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
                <h3 class="myticket">My Tickets</h3>
                @if ($userTickets->isEmpty())
                <div class="no-record">
                    <i class="fa-solid fa-clapperboard"></i>
                    <p>No record found</p>
                </div>
                @else
                @foreach ($userTickets as $orderNo => $tickets) <!-- Loop through each order -->
                <div class="ticket-container">
                    <table class="ticket-table">
                        <tr>
                            <th style="width: 123px; background-color: #FF0000;">Cinema</th>
                            <th style="background-color: #333;">{{ $tickets->first()->cinemaName }}</th> <!-- Cinema name from the first ticket -->
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="ticket">
                                    <div class="theater-info">
                                        <img src="data:image/png;base64,{{ base64_encode($tickets->first()->movieImage) }}" alt="Movie Image"> <!-- Movie Image -->
                                        <div class="movie-info">
                                            <h2>{{ $tickets->first()->movieTitle }}</h2> <!-- Movie Title -->
                                            <p>Length: {{ $tickets->first()->runningTime }} minutes</p> <!-- Running time -->
                                        </div>
                                    </div>
                                    <div class="showtime-info">
                                        <p>{{ \Carbon\Carbon::parse($tickets->first()->movieDateTime)->format('l') }}</p>
                                        <h3>{{ \Carbon\Carbon::parse($tickets->first()->movieDateTime)->format('d F Y') }}</h3>
                                        <h2>{{ \Carbon\Carbon::parse($tickets->first()->movieDateTime)->format('H:i') }}</h2>
                                    </div>
                                    <div class="qr">
                                        <img src="data:image/png;base64,{{ base64_encode($tickets->first()->QRCode) }}" alt="Qr Image"> <!-- QR Code -->
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 123px; background-color: #00921d; border-bottom-left-radius: 5px; text-align: center;">
                                <a href="{{ route('viewOrder', ['orderNo' => $orderNo]) }}" style="color: #f0f0f0;">View Ticket</a>
                            </td>
                            <td style="background-color: #333; border-bottom-right-radius: 5px;">
                                &nbsp Seat(s): 
                                @foreach ($tickets as $ticket)
                                {{ $ticket->seat }} <!-- Display each seat in the order -->
                                @if (!$loop->last), @endif <!-- Add a comma between seats except for the last seat -->
                                @endforeach
                            </td>
                        </tr>
                    </table>
                </div>
                @endforeach
                @endif
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
