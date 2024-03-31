import React, { useState } from 'react';
import NavbarNew from '../../components/navbar/NavbarNew';
import person from '../../assets/person.png';
import './LoginStyles.css';

function LogIn() {
  const[user, setUser] = useState([]);
  const [formData, setFormData] = useState({
    fullName: ''
  });

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch(`http://localhost:5000/login?fullName=${formData.fullName}`);
      const data = await response.json();
      console.log(data)
      setUser(data.users);
      

      // Clear the form data after successful submission
      setFormData({
        fullName: ''
      });
    } catch (error) {
      console.error('Error fetching hotels:', error);
    }
  };

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
  };

  return (
    <div className='login-container'>
      <NavbarNew />
      <div className='container'>
        <div className="header">
          <div className="text">Log in</div>
        </div>
        <form onSubmit={handleSubmit}>
          <div className="inputs">
            <div className="input">
              <img src={person} alt="Person icon"/>
              <label htmlFor="fullName">Full Name</label>
              <input
                type="text"
                id="fullName"
                name="fullName"
                value={formData.fullName}
                placeholder='Enter your full name'
                onChange={handleInputChange}
              />
            </div>
          </div>
          <div className="submit-container">
            <button type="submit" className="submit">Log In</button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default LogIn;
