
  <link rel="stylesheet" href="{{asset('css/movie-card.css')}}">
    <div class="movie-card">
      <img class="movieIMG" src="{{ route('movie.imageVertical', ['id' => $movie['movieID']]) }}" alt="Movie Image">
      <div class="bookInfo">
        <x-class-logo :class="$movie['classification']" ></x-class-logo>
        <a href="{{ url('details/' . rawurlencode($movie['movieID'])) }}" class="bookBtn">BOOK NOW</a>
      </div>
      <div class="container">
        <h3>{{$movie['movieTitle']}}</h3> 
      </div>
    </div>
