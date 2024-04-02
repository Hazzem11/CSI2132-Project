import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import person from '../../assets/person.png';
import './LoginStyles.css';

function LogIn() {
  const [user, setUser] = useState([]);
  const [formData, setFormData] = useState({
    fullName: ''
  });
  const navigate = useNavigate();


 

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const update = await fetch(`http://localhost:3001/update?`);




      const response = await fetch(`http://localhost:3001/login?fullName=${formData.fullName}`);
      const data = await response.json();
      setUser(data.users[0]);
      console.log("Current User")
      console.log(data.users[0].user_type)
    

      // Redirect based on user_type
      if (data.users[0].user_type === "Employee") {
        console.log(data.users[0].user_full_name);
        navigate(`/booking/${data.users[0].user_full_name}/${data.users[0].hotel_address}`); 
        
      } else if (data.users[0].user_type === 'Customer') {
        navigate("/home");
      }
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

