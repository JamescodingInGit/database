<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Slider</title>
    <link rel="stylesheet" href="styles.css">
</head>
<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;

    }

    .slider {
        position: relative;
        width: 100%;
        height: 100vh;
        overflow: hidden;
    }

    .slides {
        display: flex;
        width: 100%;
        height: 100%;
        transition: transform 0.5s ease-in-out;
    }

    .slide {
        position: relative;
        min-width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        color: white;
    }

    .background-image {
        position: absolute;
        width: 100%;
        height: 100%;
        object-fit: cover;
        z-index: -1;
        filter: brightness(0.5);
    }

    div.slide > .movie-info {
        max-width: 40%;
        text-align: left;
        position: absolute;
        top: 50%;
        left: 8%;

    }

    .movie-info h1 {
        font-size: 3em;
        margin-bottom: 10px;
    }

    .year,
    .rating {
        font-size: 1.2em;
        margin-right: 10px;
    }

    .watch-now {
        background-color: red;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 1em;
        cursor: pointer;
        margin-top: 20px;
    }

    * {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
    }

    .nav {
        position: fixed;
        top: 0;
        display: flex;
        justify-content: space-around;
        width: 100%;
        height: 100px;
        line-height: 100px;
        background: linear-gradient(rgba(39, 39, 39, 0.6), transparent);
        z-index: 100;
    }

    .nav-logo span {
        color: white;
        font-size: 25px;
        font-weight: 600;
    }

    .nav-menu ul {
        display: flex;
    }

    .nav-menu ul li {
        list-style-type: none;
    }

    .nav-menu ul li .link {
        text-decoration: none;
        font-weight: 500;
        color: #fff;
        padding-bottom: 15px;
        margin: 0 25px;
    }

    .link:hover,
    .active {
        border-bottom: 2px solid #fff;
    }

    .nav-button .btn {
        width: 130px;
        height: 40px;
        font-weight: 500;
        background: rgba(255, 255, 255, 0.4);
        border: none;
        border-radius: 30px;
        cursor: pointer;
        transition: .3s ease;
    }

    .btn:hover {
        background: rgba(255, 255, 255, 0.3);
    }

    #registerBtn {
        margin-left: 15px;
    }

    .btn.white-btn {
        background: rgba(255, 255, 255, 0.7);
    }

    .btn.btn.white-btn:hover {
        background: rgba(255, 255, 255, 0.5);
    }

    .nav-menu-btn {
        display: none;
    }

    .form-box {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 512px;
        height: 420px;
        overflow: hidden;
        z-index: 2;
    }

    .login-container {
        position: absolute;
        left: 4px;
        width: 500px;
        display: flex;
        flex-direction: column;
        transition: .5s ease-in-out;
    }

    .register-container {
        position: absolute;
        right: -520px;
        width: 500px;
        display: flex;
        flex-direction: column;
        transition: .5s ease-in-out;
    }

    .top span {
        color: #fff;
        font-size: small;
        padding: 10px 0;
        display: flex;
        justify-content: center;
    }

    .top span a {
        font-weight: 500;
        color: #fff;
        margin-left: 5px;
    }

    /* Movie Listing */
    .movie-listing {
        text-align: center;
    }

    .movie-listing h2 {
        width: 100%;
        margin-top: 30px;
        background-color: #f4f4f4;
    }

    .movie-listing h2 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 28px;
        color: #333;
    }

    .grid-container {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        /* Ensure equal width for all grid items */
        padding: 40px;
        gap: 20px;
    }

    .grid-item {
        background-color: rgba(255, 255, 255, 0.8);
        font-size: 18px;
        text-align: center;
        height: 370px;
        position: relative;
        overflow: hidden;
    }

    .grid-item:hover .hover-display {
        opacity: 1;
        /* Show info and actions on hover */
    }

    .hover-display {
        opacity: 0;
        transition: opacity 0.3s ease-in-out;
        position: absolute;
        gap: 80px;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        display: flex;
        color: white;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        background-color: rgba(0, 0, 0, 0.7);
    }


    .movie-poster {
        width: 100%;
        height: 370px;
        max-height: 370;
    }


    .watch-now,
    .details {
        text-decoration: none;
        color: #fff;
        background-color: #333;
        padding: 8px 12px;
        margin: 5px;
        border-radius: 5px;
    }

    .watch-now:hover,
    .details:hover {
        background-color: #555;
    }
</style>

<body>
    <nav class="nav">
        <div class="nav-logo">
            <div class="logo-text">
                <span class="jobmatch">MovieCinema</span>
            </div>
        </div>
        <div class="nav-menu" id="navMenu">
            <ul>
                <li><a href="#" class="link active">Home</a></li>
                <li><a href="#" class="link">About</a></li>
                <li><a href="#" class="link">Cinema</a></li>
                <li><a href="#" class="link">Movie</a></li>
            </ul>
        </div>
        <div class="nav-button">
            <button class="btn white-btn" id="loginBtn" onclick="login()">Sign Up</button>
        </div>
        <div class="nav-menu-btn">
            <i class="bx bx-menu" onclick="myMenuFunction()"></i>
        </div>
    </nav>


    <div class="slider">
        <div class="slides">
            <!-- Movie Slide 1 -->
            <div class="slide active">
                <img src="images/company1.jpg" alt="Beetlejuice" class="background-image" style="">
                <div class="movie-info">
                    <h1>Beetlejuice Beetlejuice</h1>
                    <span class="year">2024</span>
                    <span class="rating">7.2</span>
                    <p>Comedy, Horror, Fantasy</p>
                    <p>After a family tragedy, three generations of the Deetz family return home to Winter River. Still
                        haunted by Beetlejuice, ...</p>
                    <button class="watch-now">Watch Now</button>
                </div>
            </div>

            <!-- Additional movie slides can go here -->
            <div class="slide">
                <img src="images/company2.jpg" alt="Another Movie" class="background-image">
                <div class="movie-info">
                    <h1>Another Movie Title</h1>
                    <span class="year">2023</span>
                    <span class="rating">8.5</span>
                    <p>Action, Adventure</p>
                    <p>Short description of the movie...</p>
                    <button class="watch-now">Watch Now</button>
                </div>
            </div>

            <div class="slide">
                <img src="images/homeBackground.jpg" alt="Another Movie" class="background-image">
                <div class="movie-info">
                    <h1>Another Movie Title</h1>
                    <span class="year">2023</span>
                    <span class="rating">8.5</span>
                    <p>Action, Adventure</p>
                    <p>Short description of the movie...</p>
                    <button class="watch-now">Watch Now</button>
                </div>
            </div>


            <div class="slide">
                <img src="images/jobSearchBackground.jpg" alt="Another Movie" class="background-image">
                <div class="movie-info">
                    <h1>Another Movie Title</h1>
                    <span class="year">2023</span>
                    <span class="rating">8.5</span>
                    <p>Action, Adventure</p>
                    <p>Short description of the movie...</p>
                    <button class="watch-now">Watch Now</button>
                </div>
            </div>

            <!-- Add more slides if necessary -->
        </div>
    </div>

    <div class="movie-listing">
        <h2>Movie Listing</h2>
        <div class="grid-container">
            <div class="grid-item">
                <img src="images/homeBackground.jpg" alt="${movie.title}" class="movie-poster">
                <div class="hover-display">
                    <div class="movie-info">
                        <h3 class="movie-title">${movie.title}</h3>
                        <p class="movie-genre">Genre: ${movie.genre}</p>
                        <p class="movie-rating">Rating: ${movie.rating}</p>
                        <p class="movie-year">Year: ${movie.year}</p>
                        <p class="movie-time">${movie.time}</p>
                    </div>
                    <div class="movie-actions">
                        <a href="#" class="watch-now">Watch Now</a>
                        <a href="#" class="details">Details</a>
                    </div>
                </div>
            </div>
            <div class="grid-item">2</div>
            <div class="grid-item">3</div>
            <div class="grid-item">4</div>
            <div class="grid-item">5</div>
            <div class="grid-item">6</div>
            <div class="grid-item">7</div>
            <div class="grid-item">8</div>
            <div class="grid-item">9</div>
        </div>
    </div>

</body>
<script>
    let currentSlide = 0;
    const slides = document.querySelectorAll('.slide');
    const totalSlides = slides.length;

    function showSlide(index) {
        slides.forEach((slide, i) => {
            slide.classList.toggle('active', i === index);
        });

        document.querySelector('.slides').style.transform = `translateX(-${index * 100}%)`;
    }

    function nextSlide() {
        currentSlide = (currentSlide + 1) % totalSlides;
        showSlide(currentSlide);
    }

    setInterval(nextSlide, 7000); // Change slide every 7 seconds

</script>

</html>