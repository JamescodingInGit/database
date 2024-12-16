let previousIndex = 0;
let currentSlide = 0;
  showSlides(slideIndex);
  
  function showSlides(n) {
    let slides = document.getElementsByClassName("slide");
    let dots = document.getElementsByClassName("nav-dot");
    slides[n].classList.add('active');
    dots[n].classList.add('active');
    slides[previousIndex].classList.remove('active');
    dots[previousIndex].classList.remove('active');
    previousIndex = n;
    currentSlide = n;
  }

function nextSlide() {
    previousIndex = currentSlide;
    currentSlide = (currentSlide + 1) % slides.length;
    showSlides(currentSlide);
}

setInterval(nextSlide, 5000); 

function leftMovie() {
  const scrollingWrapper = document.getElementById('scrollingWrapper');
  scrollingWrapper.scrollBy({ left: -240, behavior: 'smooth' }); 
}

function rightMovie() {
  const scrollingWrapper = document.getElementById('scrollingWrapper');
  scrollingWrapper.scrollBy({ left: 240, behavior: 'smooth' }); 
}

function slideActive(){
  const slide = document.getElementsByClassName("slide");
  slide[0].classList.add("active");
  const navDot = document.getElementsByClassName("nav-dot");
  navDot[0].classList.add("active");
}

function movieSelect(type) {
  // Define the mapping of types to container classes
  const typeMapping = {
      nowShowing: 'movieActive',
      bookEarly: 'movieActive',
      comingSoon: 'movieActive'
  };

  // Remove 'foodActive' class from all food containers
  const containers = document.querySelectorAll('.scrolling-wrapper');
  containers.forEach(container => container.classList.remove('movieActive'));

  // Remove 'foodDrinkNavBarActive' class from all nav links
  const navLinks = document.querySelectorAll('.movieNavbar a');
  navLinks.forEach(link => link.classList.remove('movieNavBarActive'));

  // Add 'foodActive' class to the selected container
  const activeContainer = document.querySelector(`.${type}`);
  if (activeContainer) {
      activeContainer.classList.add(typeMapping[type]);
  }

  // Add 'foodDrinkNavBarActive' class to the selected link
  const activeLink = Array.from(navLinks).find(link => link.textContent.trim().toLowerCase() === type.replace(/([A-Z])/g, ' $1').toLowerCase());
  if (activeLink) {
      activeLink.classList.add('movieNavBarActive');
  }
}