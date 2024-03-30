import React from 'react';
import '../../components/navbar/navbarStyles.css';
import { Link } from 'react-router-dom';


function BookingNavbar() {
  return (
    <div className='navbar'>
      <div className="logo">
        <h2>Find your next stay</h2>
      </div>
      <ul className="nav-menu">
      <li><Link to="/"><button className="nav-button">Home</button></Link></li>
      <li><Link to="/booking"><button className="nav-button">Book</button></Link></li>
      <li><Link to="/login"><button className="login-button">Sign Up</button></Link></li>
      <li><Link to="/profile"><button className="profile-button">Profile</button></Link></li>
    </ul>
    
    </div>
  );
}

export default BookingNavbar;