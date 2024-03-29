import React from 'react';
import './navbarStyles.css';
import { Link } from 'react-router-dom';


function NavbarNew() {
  return (
    <div className='navbar'>
      <div className="logo">
        <h2>Book Now!</h2>
      </div>
      <ul className="nav-menu">
      <li><Link to="/"><button className="nav-button">Home</button></Link></li>
      <li><Link to="/hotel-chains"><button className="nav-button">Chains</button></Link></li>
      <li><Link to="/login"><button className="login-button">Sign Up</button></Link></li>
    </ul>
    
    </div>
  );
}

export default NavbarNew;