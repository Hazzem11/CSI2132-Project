import React from 'react';
import './navbarStyles.css';
import { Link } from 'react-router-dom';


function NavbarNew() {
  return (
    <div className='navbar'>
      <div className="logo">
        <h2>Explore our Hotels</h2>
      </div>
      <ul className="nav-menu">
      <li><Link to="/home"><button className="nav-button">Home</button></Link></li>
      <li><Link to="/booking"><button className="nav-button">Book</button></Link></li>
    </ul>
    
    </div>
  );
}

export default NavbarNew;