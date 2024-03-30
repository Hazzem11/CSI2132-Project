import React from 'react';
import './HeroStyles.css';
import Video from '../../assets/cool-hotel.mp4';

function Hero() {
  const hotels = [
    { id: 1, name: 'Hotel A', chainName: 'Chain A', starRating: 4 },
    { id: 2, name: 'Hotel B', chainName: 'Chain B', starRating: 3 },
    { id: 3, name: 'Hotel C', chainName: 'Chain C', starRating: 5 },
  ];

  return (
    <div className='hero'>
      <video autoPlay loop muted id='video'>
        <source src={Video} type='video/mp4' />
      </video>
      <div className='overlay'></div>
      <div className="search">
            <form className="form">
              
              <div>
                <label htmlFor="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" />
              </div>
              <div>
                <label htmlFor="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" />
              </div>
              <div>
                <label htmlFor="roomCapacity">Room Capacity:</label>
                <input type="number" id="roomCapacity" name="roomCapacity" />
              </div>
              <div>
                <label htmlFor="area">Area:</label>
                <input type="text" id="area" name="area" />
              </div>
              <div>
                <label htmlFor="hotelChain">Hotel Chain:</label>
                <input type="text" id="hotelChain" name="hotelChain" />
              </div>
              <div>
                <label htmlFor="hotelCategory">Hotel Category:</label>
                <select id="hotelCategory" name="hotelCategory">
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
                <input type="number" id="totalRooms" name="totalRooms" />
              </div>
              <div>
                <label htmlFor="roomPrice">Price of Rooms:</label>
                <input type="number" id="roomPrice" name="roomPrice" />
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
      <div/>
    </div> 
  );
}

export default Hero;
