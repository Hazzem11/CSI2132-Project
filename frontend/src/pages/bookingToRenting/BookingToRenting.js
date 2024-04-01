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
      const response = await fetch(`http://localhost:3001/bookings?customer_full_name=${formData.fullName}
      &employee_full_name=${formData.employeeFullName}
      `);
      const data = await response.json();
      setBookings(data.bookings); 
      
     
      
    } catch (error) {
      console.error('Error fetching hotels:', error);
    }
  };

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
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
      <li key={`${booking.customer_ssn}-${booking.room_number}-${booking.hotel_address}`}>
        {booking.room_number} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stars: {booking.hotel_address}
        {/* <button onClick={() => handleViewRooms(hotel.hotel_address)}>View Rooms</button> */}
      </li>
    ))}
  </ul>
</div>
  </div> 
);
}

export default BookingToRenting;