

  function drop() {
    console.log("Function called");
    const elem = document.getElementById('role');
    
    
      if (elem.value === 'Driver') {
        document.getElementById("driver_details").style.display = "block"; 
        document.getElementById("vehicle_details").style.display = "block";
        document.getElementById("rider_details").style.display = "none";  
      } else if (elem.value == "Rider") {
        document.getElementById("rider_details").style.display = "block";
        document.getElementById("driver_details").style.display = "none"; 
        document.getElementById("vehicle_details").style.display = "none"; 
      }else{
        document.getElementById("driver_details").style.display = "none"; 
        document.getElementById("vehicle_details").style.display = "none"; 
        document.getElementById("rider_details").style.display = "none";
      } 
    
  }


  document.addEventListener('DOMContentLoaded', function() {
    event.preventDefault();
    var resetButton = document.getElementById('reset-button');
    var fileField = document.querySelector('input[type="file"]');

    resetButton.addEventListener('click', function() {
      fileField.value = null;
      return false;
    });
  });


  document.addEventListener('DOMContentLoaded', function() {
    event.preventDefault();
    var resetButton = document.getElementById('reset-button-1');
    var fileField = document.getElementById("aadhar_image");
  
    resetButton.addEventListener('click', function() {
      console.log("Rider called")
      
      fileField.value = null;
      return false;
    });
  });

  