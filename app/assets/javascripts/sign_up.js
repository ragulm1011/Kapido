

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