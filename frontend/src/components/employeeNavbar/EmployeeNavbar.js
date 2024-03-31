import React from 'react';
import './EmployeeNavbarStyles.css';
import { Link } from 'react-router-dom';


function EmployeeNavbar() {
  return (
    <div className='navbar'>
      <div className="logo">
        <h2>Welcome Employee</h2>
      </div>
      <ul className="nav-menu">
      <li><Link to="/"><button className="nav-button">Home</button></Link></li>
      <li><Link to="/booking"><button className="nav-button">Book</button></Link></li>
      <li><Link to="/walk-in-rent"><button className="login-button">Walk In</button></Link></li>
      <li><Link to="/booking-to-renting"><button className="profile-button">Booking to Renting</button></Link></li>
    </ul>
    
    </div>
  );
}

export default EmployeeNavbar;