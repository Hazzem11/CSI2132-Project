import React from 'react';
import './navbarStyles.css';

function NavbarNew() {
  return (
    <div className='navbar'>
      <div className="logo">
        <h2>Book Now!</h2>
      </div>
      <ul className="nav-menu">
        <button className="nav-button">Hotels</button>
        <button className="nav-button">Chains</button>
        <li><button className="login-button">Login</button></li>
      </ul>
    
    </div>
  );
}

export default NavbarNew;