<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>TGV</title>
        <link rel="stylesheet" href="{{asset('css/home.css')}}">
        <script src="{{asset('js/home.js')}}"></script>
    </head>
    <body>
        <x-navbar></x-navbar>
        <div class="slider-container">
            <div class="slider">
                <div class="slides">

                    @foreach($movies as $movie)
                        <div class="slide">
                            <img src="{{ route('movie.imageHorizontal', ['id' => $movie['movieID']]) }}" alt="Movie Image" />
                            <div class="slide-content">
                                <h2>{{$movie['movieTitle']}}</h2>
                                <div class="buttons">
                                    <a href="#" class="button">BOOK NOW</a>
                                </div>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
    
            <div class="navigation">
                @foreach($movies as $movie)
                    <span class="nav-dot" onclick="showSlides({{$loop->index}})"></span> 
                @endforeach
            </div>
        </div>
        <div class="movieNavbar">
            <a href="#" class="movieNavBarActive" onclick="movieSelect('nowShowing')">Now Showing</a>
            <a href="#" onclick="movieSelect('bookEarly')">Book Early</a>
            <a href="#" onclick="movieSelect('comingSoon')">Coming Soon</a>
        </div>
    
        <div class="container">
            <button onclick="leftMovie()" class="scroll-btn left-btn">&lt;</button>
            <div class="scrolling-wrapper movieActive nowShowing" id="scrollingWrapper">
                @foreach($movies as $movie)
                    <x-movie-card :data="$movie"></x-movie-card>
                @endforeach
            </div>

            <div class="scrolling-wrapper bookEarly" id="scrollingWrapper">
                @foreach($movies as $movie)
                    <x-movie-card :data="$movie"></x-movie-card>
            @endforeach
            </div>

            <div class="scrolling-wrapper comingSoon" id="scrollingWrapper">
                @foreach($movies as $movie)
                <x-movie-card :data="$movie"></x-movie-card>
            @endforeach
            </div>
            <button onclick="rightMovie()" class="scroll-btn right-btn">&gt;</button> 
        </div>
        
        <script>slideActive()</script>
    </body>
    
</html>
