import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import './HeroStyles.css';
import Video from '../../assets/cool-hotel.mp4';
import { useParams } from "react-router-dom";

function Hero() {
  // State variables to store form input values
  
  const [hotels, setHotels] = useState([]);
  const [formData, setFormData] = useState({
    area: '',
    hotelChain: '',
    hotelCategory: '',
    totalRooms: '',
  });

  const navigate = useNavigate();

  

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch(`http://localhost:3001/hotels?area=${formData.area}&hotelChain=${formData.hotelChain}&hotelCategory=${formData.hotelCategory}&totalRooms=${formData.totalRooms}`);
      
      const data = await response.json();
      console.log(data)
      setHotels(data.hotels); 

      // Clear the form data after successful submission
      setFormData({
        area: '',
        hotelChain: '',
        hotelCategory: '',
        totalRooms: '',
      });
    } catch (error) {
      console.error('Error fetching hotels:', error);
    }
  };

  const handleInputChange = (event) => {
    
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
  };

 
  const handleViewRooms = (hotel_address) => {

    navigate(`/booking/${undefined}/${hotel_address}`); 
  };

  return (
    <div className='hero'>
      <video autoPlay loop muted id='video'>
        <source src={Video} type='video/mp4' />
      </video>
      <div className='overlay'></div>
      <div className="search">
        <form className="form" onSubmit={handleSubmit}>
          <div>
            <label htmlFor="area">Location:</label>
            <input type="text" id="area" name="area" value={formData.area} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="hotelChain">Hotel Chain:</label>
            <select id="hotelChain" name="hotelChain" value={formData.hotelChain} onChange={handleInputChange}>
              <option value="">Select a Chain</option>
              <option value="Hezi Grand Heights HQ, New York, New York, United States">Hezi Grand Heights</option>
              <option value="Emerald Hills Inc. HQ, Los Angeles, California, United States">Emerald Hills Inc.</option>
              <option value="Mounir Luxury Resorts HQ, Miami, Florida, United States">Mounir Luxury Resorts</option>
              <option value="Sunset Vista Hotels HQ, Ottawa, Ontario, Canada">Sunset Vista Hotels</option>
              <option value="ZouZou International HQ, Beirut, Lebanon">ZouZou International</option>
            </select>
          </div>
          <div>
            <label htmlFor="hotelCategory">Hotel Category:</label>
            <select id="hotelCategory" name="hotelCategory" value={formData.hotelCategory} onChange={handleInputChange}>
              <option value="">Select a category</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
            </select>
          </div>
          <div>
            <label htmlFor="totalRooms">Minimum Rooms:</label>
            <input type="number" id="totalRooms" name="totalRooms" value={formData.totalRooms} onChange={handleInputChange} />
          </div>
          <button type="submit">Search</button>
        </form>
      </div>
      <div className='hotel-view'>
  <h1>Hotels</h1>
  <ul>
    {hotels.map((hotel) => (
      <li key={hotel.hotel_address}>
        {hotel.hotel_address} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stars: {hotel.star_rating}
        <button onClick={() => handleViewRooms(hotel.hotel_address)}>View Rooms</button>
      </li>
    ))}
  </ul>
    </div>


    </div> 
  );
}

export default Hero;
