function load(seatMap, soldMap) {
  const arrayMap = JSON.parse(seatMap);
  const soldArray = JSON.parse(soldMap);
  const seatSelection = document.getElementsByClassName("seat-selection")[0];
  let i = 65; // ASCII value for 'A'
  let seatNum = 0;

  arrayMap.forEach((rowArray, rowIndex) => {
    seatNum = 1;
    const rowDiv = document.createElement("div");
    rowDiv.classList.add("row");

    const rowAlphabetStart = document.createElement("h3");
    const rowAlphabetEnd = document.createElement("h3");

    rowAlphabetStart.innerHTML = String.fromCharCode(i);
    rowAlphabetEnd.innerHTML = String.fromCharCode(i);

    rowAlphabetStart.classList.add("leftAlphabet");
    rowAlphabetEnd.classList.add("rightAlphabet");

    rowDiv.appendChild(rowAlphabetStart);

    rowArray.forEach((seatValue, seatIndex) => {
      const seat = document.createElement("button");
      seat.classList.add("seat");

      const seatLabel = `${String.fromCharCode(i)}${seatIndex + 1}`;
      seat.setAttribute('data-tooltip', `${seatLabel}`);

      const isSold = soldArray[rowIndex] && soldArray[rowIndex][seatIndex] === 1;

      if (isSold) {
        seat.classList.add("occupied"); 
        const seatLabel = `${String.fromCharCode(i)}${seatNum}`;
        seat.setAttribute('data-tooltip', `${seatLabel}`);
        seatNum++;
      } else if (seatValue === 0) {
        seat.classList.add("none"); 
      } else if (seatValue === 1) {
        const seatLabel = `${String.fromCharCode(i)}${seatNum}`;
        seat.setAttribute('data-tooltip', `${seatLabel}`);
        seat.classList.add("available");
        seatNum++; 
      }

      seat.onclick = function() {
        handleSeatClick(seat, seatValue);
      };

      rowDiv.appendChild(seat);
    });

    rowDiv.appendChild(rowAlphabetEnd);
    seatSelection.appendChild(rowDiv);

    i++;
  });
}



let selectedSeats = [];

function handleSeatClick(seat, seatValue) {
    if (seatValue === 1) { // Available seat
        const seatLabel = seat.getAttribute('data-tooltip'); // Seat label like 'A2'
        
        if (selectedSeats.includes(seatLabel)) {
            // Deselect if already selected
            selectedSeats = selectedSeats.filter(s => s !== seatLabel);
            seat.classList.remove('selected');
        } else {
            // Select the seat
            selectedSeats.push(seatLabel);
            seat.classList.add('selected');
        }

        updateModalSeats();
    } else if (seatValue === 2) {
        alert("Occupied seat clicked!");
    } else {
        alert("Unavailable seat clicked!");
    }
}

function updateModalSeats() {
  const seatNames = document.getElementById('seat-names');
  const hiddenSeatInput = document.querySelector('input[name="seat"]'); // Get the hidden input field

  if (selectedSeats.length > 0) {
      seatNames.textContent = selectedSeats.join(', '); // Display seat labels
      hiddenSeatInput.value = selectedSeats.join(', ');  // Set the hidden input value with selected seats
      document.getElementsByClassName('book-button')[0].classList.remove("disabled");
  } else {
      seatNames.textContent = 'None';
      hiddenSeatInput.value = '';  // Clear the hidden input value
      document.getElementsByClassName('book-button')[0].classList.add("disabled");
  }
}


function navBar(){
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
}

function openModal() {
  document.getElementById('ticketModal').style.display = 'flex';
  let input = document.getElementsByClassName('ticket-input');
  input[0].value = selectedSeats.length;
}

function closeModal() {
  document.getElementById('ticketModal').style.display = 'none';
}

function updateTicketCount(change, type) {
  let inputs = document.getElementsByClassName('ticket-input');
  
  // Ensure the type parameter is within bounds
  if (type >= 0 && type < inputs.length) {
      // Get the specific input element based on the type
      let input = inputs[type];
      let currentValue = parseInt(input.value) || 0;
      let newValue = currentValue + change;

      // Get the total number of tickets
      let totalTickets = 0;
      for (let i = 0; i < inputs.length; i++) {
          totalTickets += parseInt(inputs[i].value) || 0;
      }

      // Check if the new value is within the valid range
      if (newValue >= 0 && totalTickets + change <= selectedSeats.length) {
          input.value = newValue;
      }

      if(totalTickets <=0){
        document.getElementsByClassName('book-button')[1].classList.add("disabled");
      }
  }
}


