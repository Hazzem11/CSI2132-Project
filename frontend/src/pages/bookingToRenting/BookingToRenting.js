import React, { useState } from 'react';
import './BookingToRentingStyles.css';
import Video from '../../assets/cool-hotel.mp4';
import EmployeeNavbar from '../../components/navbar/EmployeeNavbar';

function BookingToRenting() {
  const [bookings, setBookings] = useState([]);
  const [formData, setFormData] = useState({
    fullName : '',
    employeeFullName : ''
    
  });

 
  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch(`http://localhost:3001/bookings?customer_full_name=${formData.fullName}`);
      const data = await response.json();
      console.log(data);
      setBookings(data.bookings); 
      
     
      
    } catch (error) {
      console.error('Error fetching hotels:', error);
    }
  };

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
  };
  const handleSubmitRent = async (roomNumber,hotel_address,booking_start_date,booking_end_date ) => {
  
    try {
      const rentingAvailability = await fetch(`http://localhost:3001/bookingRentable?customer_full_name=${formData.fullName}&booking_start_date=${booking_start_date}&booking_end_date=${booking_end_date}&hotel_address=${hotel_address}&room_number=${roomNumber}`);
      const data = await rentingAvailability.json();
      console.log(data);
      
      
      if (data.rentable === false) {
        alert("This room is not rentable");
        return;
      }
      else{
      const response2 = await fetch('http://localhost:3001/bookingToRenting', {
      method: 'POST',
     headers: {
    'Content-Type': 'application/json',
      },
    body: JSON.stringify({
    renting_start_date: booking_start_date,
    renting_end_date: booking_end_date,
    customer_full_name: formData.fullName,
    hotel_address: hotel_address,
    room_number: roomNumber,
    employee_full_name: formData.employeeFullName
     }),
    });
    }
      
    } catch (error) {
      console.error("Error renting room:", error);
    }
  };



    
    return ( 
    <div className='rentingToBooking'>
        <EmployeeNavbar />
    <video autoPlay loop muted id='video'>
      <source src={Video} type='video/mp4' />
    </video>
    <div className='overlay'></div>
    <div className="search">
      <form className="form" onSubmit={handleSubmit}>
      <div>
            <label htmlFor="fullName">Customer Name:</label>
            <input type="text" id="fullName" name="fullName" value={formData.fullName} onChange={handleInputChange}/>
          </div>
          <div>
            <label htmlFor="employeeFullName">Employee Name:</label>
            <input type="text" id="employeeFullName" name="employeeFullName" value={formData.employeeFullName} onChange={handleInputChange}/>
          </div>
        <button type="submit">Search</button>
      </form>
    </div>
<div className='booking-view'>
<h1>Current Bookings</h1>
<ul>
    {bookings.map((booking) => (
      <li key={booking.customer_ssn}>
        {booking.room_number} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stars: {booking.hotel_address}
        <button onClick={() => handleSubmitRent(booking.room_number,booking.hotel_address,booking.booking_start_date,booking.booking_end_date)}>Rent Out</button>
      </li>
    ))}
  </ul>
</div>
  </div> 
);
}

export default BookingToRenting;