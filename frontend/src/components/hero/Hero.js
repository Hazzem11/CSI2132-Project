import React, { useState } from 'react';
import './HeroStyles.css';
import Video from '../../assets/cool-hotel.mp4';

function Hero() {
  // State variables to store form input values
  const [hotels, setHotels] = useState([]);
  const [formData, setFormData] = useState({
    startDate: '',
    endDate: '',
    roomCapacity: '',
    area: '',
    hotelChain: '',
    hotelCategory: '',
    totalRooms: '',
    roomPrice: ''
  });

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch(`/hotels?startDate=${formData.startDate}&endDate=${formData.endDate}&roomCapacity=${formData.roomCapacity}&area=${formData.area}&hotelChain=${formData.hotelChain}&hotelCategory=${formData.hotelCategory}&totalRooms=${formData.totalRooms}&roomPrice=${formData.roomPrice}`);
      const data = await response.json();
      setHotels(data.hotels); 
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
            <label htmlFor="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" value={formData.startDate} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" value={formData.endDate} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="roomCapacity">Room Capacity:</label>
            <input type="number" id="roomCapacity" name="roomCapacity" value={formData.roomCapacity} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="area">Area:</label>
            <input type="text" id="area" name="area" value={formData.area} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="hotelChain">Hotel Chain:</label>
            <input type="text" id="hotelChain" name="hotelChain" value={formData.hotelChain} onChange={handleInputChange} />
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
            <label htmlFor="totalRooms">Total Number of Rooms:</label>
            <input type="number" id="totalRooms" name="totalRooms" value={formData.totalRooms} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="roomPrice">Price of Rooms:</label>
            <input type="number" id="roomPrice" name="roomPrice" value={formData.roomPrice} onChange={handleInputChange} />
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
