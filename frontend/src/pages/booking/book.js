import React, {useState} from 'react'
import BookingNavbar from './BookingNavbar'
import './BookingStyling.css';
import Video from '../../assets/cool-hotel.mp4';



function Book() {
  // State variables to store form input values
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [roomCapacity, setRoomCapacity] = useState('');
  const [roomPrice, setRoomPrice] = useState('');
  const [amenities, setAmenities] = useState('');
  const [area, setArea] = useState('');
  const [hotelStars, setHotelStars] = useState('');

  // Function to handle form submission
  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      // Make GET request to backend API with form data
      const response = await fetch(`/rooms?startDate=${startDate}&endDate=${endDate}&roomCapacity=${roomCapacity}&roomPrice=${roomPrice}&amenities=${amenities}&area=${area}&hotelStars=${hotelStars}`);
      const data = await response.json();
      // Handle response data and update the UI as needed
    } catch (error) {
      console.error('Error fetching rooms:', error);
      // Handle errors
    }
  };

  // Function to handle input changes
  const handleInputChange = (event) => {
    const { name, value } = event.target;
    // Update the corresponding state based on the input field name
    switch (name) {
      case 'startDate':
        setStartDate(value);
        break;
      case 'endDate':
        setEndDate(value);
        break;
      case 'roomCapacity':
        setRoomCapacity(value);
        break;
      case 'roomPrice':
        setRoomPrice(value);
        break;
      case 'amenities':
        setAmenities(value);
        break;
      case 'area':
        setArea(value);
        break;
      case 'hotelStars':
        setHotelStars(value);
        break;
      default:
        break;
    }
  };

  return (
     <div className='booking'>
      <video autoPlay loop muted id='video'>
        <source src={Video} type='video/mp4' />
      </video>
    <BookingNavbar/>
    <div className='overlay'></div>
      <div className="search">
        <form className="form" onSubmit={handleSubmit}>
          {/* Input fields for search criteria */}
          <div>
            <label htmlFor="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" value={startDate} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" value={endDate} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="roomCapacity">Room Capacity:</label>
            <input type="number" id="roomCapacity" name="roomCapacity" value={roomCapacity} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="roomPrice">Room Price:</label>
            <input type="number" id="roomPrice" name="roomPrice" value={roomPrice} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="amenities">Amenities:</label>
            <input type="text" id="amenities" name="amenities" value={amenities} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="area">Area:</label>
            <input type="text" id="area" name="area" value={area} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="hotelStars">Hotel Stars:</label>
            <select id="hotelStars" name="hotelStars" value={hotelStars} onChange={handleInputChange}>
              <option value="">Select a star rating</option>
              <option value="1">1 star</option>
              <option value="2">2 stars</option>
              <option value="3">3 stars</option>
              <option value="4">4 stars</option>
              <option value="5">5 stars</option>
            </select>
          </div>
          <button type="submit">Search</button>
        </form>
        </div>
        <div className='room-view'>
        <h1>Rooms</h1>
        {/* <ul>
          {hotels.map((hotel) => (
            <li key={hotel.id}>
              <strong>{hotel.name}</strong> - Chain name: {hotel.chainName}, {hotel.starRating} stars
            </li>
          ))}
        </ul> */}
      </div>
      </div>
    );
}

export default Book
