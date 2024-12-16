<link rel="stylesheet" href="{{asset('css/navbar.css')}}">
  <body onload="scrollFunction()">
    <nav class="navbar top">
        <div class="logo">
            <img src="{{ asset('image/tgv-logo.png') }}" alt="TGV Logo">
        </div>
        <ul class="nav-links">
            <li><a href="#">MOVIES</a></li>
            <li><a href="#">PROMOTIONS</a></li>
        </ul>
        @if(user())
            <div class="sign-in">
              <a href="{{ url('/myticket') }}">SIGN IN</a>
          </div>
        @else
          <div class="sign-in">
              <a href="{{ url('/login') }}">SIGN IN</a>
          </div>
        @endif
    </nav>

    <script>
      window.onscroll = function () {
          scrollFunction()
      };

      function scrollFunction() {
          let navbar = document.getElementsByClassName("navbar");
          if (document.body.scrollTop > 10 || document.documentElement.scrollTop > 10) {
            navbar[0].classList.remove('top');
          }else{
            navbar[0].classList.add('top');
          }
      }
  </script>
  </body>
