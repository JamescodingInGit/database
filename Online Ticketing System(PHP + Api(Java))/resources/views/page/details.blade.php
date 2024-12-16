<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>TGV</title>
        <link rel="stylesheet" href="{{asset('css/details.css')}}">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

        <script src="{{asset('js/details.js')}}"></script>
    </head>
    <body>
        <x-navbar></x-navbar>
        <div class="movie-container">
            <div class="movie" style="background: url({{ route('movie.imageHorizontal', ['id' => $movie['movieID']]) }})">
                <div class="movieGradientBtt"></div>
                <div class="movie-content">
                    <h2>{{$movie['movieTitle']}}</h2>
                    <table class="movie-info">
                        <tr>
                            @php
                                $hours = floor($movie['runningTime'] / 60); // Get the number of hours
                                $minutes = $movie['runningTime'] % 60; // Get the remaining minutes
                            @endphp
                            <td><x-class-logo :class="$movie['classification']" ></x-class-logo></td>
                            <td><p>{{$movie['genre']}} &#124; {{$hours}} hr {{$minutes}} mins &#124; {{$movie['spokenLanguage']}}</p></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="buttons">
            <button class="button">MORE INFO</button>
        </div>

    @php
        use Carbon\Carbon;
    @endphp
    
    <div class="dateNavbar">
        @foreach ($showTimesDates as $date => $location)
            @php
                $movieDateTime = Carbon::parse($date); // Parse the grouped date
            @endphp
    
            <a href="{{ url('details/' . rawurlencode($movie['movieTitle']) . '/' . $date . '/' . rawurlencode($location[0]['cinemaName'])) }}">
                @if ($movieDateTime->isToday())
                    TODAY<br>
                    <p>{{ $movieDateTime->format('d M') }}</p>
                @else
                    {{ $movieDateTime->format('D') }}<br>
                    <p>{{ $movieDateTime->format('d M') }}</p>
                @endif
            </a>
        @endforeach
    </div>
    

    
    
        <div class="movie-detail-container">
                <div class="cinemaList">
                    @foreach ($cinemas as $cinema => $cinemaNames)
                    <span class="collapsible">
                        <h4>{{ $cinema }}</h4>
                        <i class="fa fa-chevron-down"></i>
                    </span>
                    
                    <ul class="cinema-list">
                        @foreach ($cinemaNames as $cinemaName => $showTimes)
                            <li>{{ $cinemaName }}</li>
                        @endforeach
                    </ul>
                    @endforeach
                </div>
            <div class="showtimeList">
                <div class="showtimeLocation">
                    <h3>{{$cinemaLocation}} - {{$cinemaName}}</h3>
                </div>
                @foreach ($showTimeList as $movieExperience  => $showTimeList)
                    <div class="showtime-container">
                        <div class="deluxe-label">
                            <h3>{{$movieExperience }}</h3>
                        </div>
                        <div class="time-options">
                            @foreach ($showTimeList as $time)
                                <a class="time-button" 
                                href="{{ url('seat/' . $time->showID) }} ">
                                    {{ \Carbon\Carbon::parse($time->movieDateTime)->format('g:i A') }}
                                </a>
                            @endforeach
                        </div>
                    </div>
                @endforeach
            </div>
        </div>

    </body>
    
</html>
