import React from 'react';
import './navbarStyles.css';
import { Link } from 'react-router-dom';


function EmployeeNavbar() {
  return (
    <div className='navbar'>
      <div className="logo">
        <h2>Explore our Hotels</h2>
      </div>
      <ul className="nav-menu">
      <li><Link to="/home"><button className="nav-button">Home</button></Link></li>
      <li><Link to="/booking"><button className="nav-button">Walk-in</button></Link></li>
      <li><Link to="/booking-to-renting"><button className="nav-button">Booking to Renting</button></Link></li>
    </ul>
    
    </div>
  );
}

export default EmployeeNavbar;