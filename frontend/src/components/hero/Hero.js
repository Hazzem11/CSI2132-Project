import React, { useState } from 'react';
import './HeroStyles.css';
import Video from '../../assets/cool-hotel.mp4';

function Hero() {
  // State variables to store form input values
  const [hotels, setHotels] = useState([]);
  const [formData, setFormData] = useState({
    area: '',
    hotelChain: '',
    hotelCategory: '',
    totalRooms: '',
  });

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch(`/hotels?area=${formData.area}&hotelChain=${formData.hotelChain}&hotelCategory=${formData.hotelCategory}&totalRooms=${formData.totalRooms}`);
      const data = await response.json();
      setHotels(data.hotels); 
      console.log(data.hotels);

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
              <option value="1">Hezi Grand Heights HQ, New York, New York, United States</option>
              <option value="2">Emerald Hills Inc. HQ, Los Angeles, California, United States</option>
              <option value="3">Mounir Luxury Resorts HQ, Miami, Florida, United States</option>
              <option value="4">Sunset Vista Hotels HQ, Ottawa, Ontario, Canada</option>
              <option value="5">ZouZou International HQ, Beirut, Lebanon</option>
            </select>
          </div>
          <div>
            <label htmlFor="hotelCategory">Hotel Category:</label>
            <select id="hotelCategory" name="hotelCategory" value={formData.hotelCategory} onChange={handleInputChange}>
              <option value="">Select a category</option>
              <option value="1">1 star</option>
              <option value="2">2 stars</option>
              <option value="3">3 stars</option>
              <option value="4">4 stars</option>
              <option value="5">5 stars</option>
            </select>
          </div>
          <div>
            <label htmlFor="totalRooms">Max Number of Rooms:</label>
            <input type="number" id="totalRooms" name="totalRooms" value={formData.totalRooms} onChange={handleInputChange} />
          </div>
          <button type="submit">Search</button>
        </form>
      </div>
      <div className='hotel-view'>
        <h1>Hotels</h1>
        <ul>
          {hotels.map((hotel) => (
            <li key={hotel.id}>
              <strong>{hotel.name}</strong> - Chain name: {hotel.chainName}, {hotel.starRating} stars
            </li>
          ))}
        </ul>
      </div>
    </div> 
  );
}

export default Hero;
