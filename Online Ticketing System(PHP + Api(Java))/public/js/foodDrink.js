function navBar() {
    window.onscroll = function () {
        scrollFunction()
    };

    function scrollFunction() {
        let navbar = document.getElementsByClassName("navbar");
        if (document.body.scrollTop > 10 || document.documentElement.scrollTop > 10) {
            navbar[0].classList.remove('top');
        } else {
            navbar[0].classList.add('top');
        }
    }
}

function openCartModal() {
    document.getElementById('cartModal').style.display = 'flex';
}

function closeCartModal() {
    document.getElementById('cartModal').style.display = 'none';
}


function openFoodModal(foodPrice, foodName, foodDrinkID) {
    document.getElementById('foodModal').style.display = 'flex';
    document.getElementById('foodImage').src = `/food-image/${foodDrinkID}`;
    document.getElementById('foodName').textContent = foodName; // Set food name
    document.getElementById('foodPrice').textContent = "RM" + parseFloat(foodPrice).toFixed(2); // Set formatted price
    document.getElementById('foodQuantity').setAttribute('name', foodDrinkID); // Store the foodDrinkID
}




function closeFoodModal() {
    document.getElementById('foodModal').style.display = 'none';
}

function foodSelect(type) {
    // Define the mapping of types to container classes
    const typeMapping = {
        alaCarteFood: 'foodActive',
        alaCarteDrinks: 'foodActive'
    };

    // Remove 'foodActive' class from all food containers
    const containers = document.querySelectorAll('.foodContainer');
    containers.forEach(container => container.classList.remove('foodActive'));

    // Remove 'foodDrinkNavBarActive' class from all nav links
    const navLinks = document.querySelectorAll('.foodDrinkNavbar a');
    navLinks.forEach(link => link.classList.remove('foodDrinkNavBarActive'));

    // Add 'foodActive' class to the selected container
    const activeContainer = document.querySelector(`.${type}`);
    if (activeContainer) {
        activeContainer.classList.add(typeMapping[type]);
    }

    // Add 'foodDrinkNavBarActive' class to the selected link
    const activeLink = Array.from(navLinks).find(link => link.textContent.trim().toLowerCase() === type.replace(/([A-Z])/g, ' $1').toLowerCase());
    if (activeLink) {
        activeLink.classList.add('foodDrinkNavBarActive');
    }
}

function foodActive() {
    const containers = document.querySelectorAll('.foodContainer');
    containers[0].classList.add('foodActive');
}

function updateFoodDrinkCount(change) {
    let input = document.getElementById('foodQuantity');

    let currentValue = parseInt(input.value) || 0;
    let newValue = currentValue + change;

    if (newValue >= 0) {
        input.value = newValue;
    }

}

