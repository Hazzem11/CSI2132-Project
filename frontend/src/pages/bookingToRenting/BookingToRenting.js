import React, { Fragment, useState } from 'react';
import './BookingToRentingStyles.css';
import Video from '../../assets/cool-hotel.mp4';
import EmployeeNavbar from '../../components/employeeNavbar/EmployeeNavbar';

function BookingToRenting() {
    const [customerName, setCustomerName] = useState("");
    console.log(customerName);
    const onSubmitForm = async (e) => {
        e.preventDefault();
    }
    return ( <div className='hero'>
        <EmployeeNavbar />
    <video autoPlay loop muted id='video'>
      <source src={Video} type='video/mp4' />
    </video>
    <div className='overlay'></div>
    <div className="search">
      <form className="form" onSubmit={onSubmitForm}>
      <div>
            <label htmlFor="area">Customer Name:</label>
            <input type="text" id="area" name="area" />
          </div>
        <div>
        </div>
        <button type="submit">Search</button>
      </form>
    </div>
    <div className='hotel-view'>
<h1>Current Bookings</h1>
</div>

  </div> 
);
}

export default BookingToRenting;