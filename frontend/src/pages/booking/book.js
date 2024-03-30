import React, {useState} from 'react'
import BookingNavbar from './BookingNavbar'
import './BookingStyling.css';
import Video from '../../assets/cool-hotel.mp4';



function Book() {
  // State variables to store form input values
  const [rooms, setrooms] = useState([])
  const [formData, setFormData] = useState({
    startDate: '',
    endDate: '',
    roomCapacity: '',
    roomPrice: '',
    amenities: '',
    area: '',
    hotelCategory: ''
  });

  // Function to handle form submission
  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      // Make GET request to backend API with form data
      const response = await fetch(
        `/rooms?startDate=${formData.startDate}
        &endDate=${formData.endDate}
        &roomCapacity=${formData.roomCapacity}
        &roomPrice=${formData.roomPrice}
        &amenities=${formData.amenities}
        &area=${formData.area}
        &hotelStars=${formData.hotelStars}`);
      const data = await response.json();
      // Clear the form data after successful submission
    setFormData({
      area: '',
      hotelChain: '',
      hotelCategory: '',
      totalRooms: '',
    });
    } catch (error) {
      console.error('Error fetching rooms:', error);
      // Handle errors
    }
  };

  // Function to handle input changes
  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
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
          
          <div>
            <label htmlFor="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" value={formData.startDate} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" value={formData.endDate} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="area">Location:</label>
            <input type="text" id="area" name="area" value={formData.area} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="roomCapacity">Room Capacity:</label>
            <input type="number" id="roomCapacity" name="roomCapacity" value={formData.roomCapacity} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="roomPrice">Room Price:</label>
            <input type="number" id="roomPrice" name="roomPrice" value={formData.roomPrice} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="amenities">Amenities:</label>
            <input type="text" id="amenities" name="amenities" value={formData.amenities} onChange={handleInputChange} />
          </div>
          <div>
            <label htmlFor="hotelStars">Hotel Stars:</label>
            <select id="hotelStars" name="hotelStars" value={formData.hotelStars} onChange={handleInputChange}>
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
        <ul>
          {rooms.map((room) => (
            <li key={room.id}>
              <strong>{room.name}</strong> - Chain name: {room.chainName}, {room.starRating} stars
            </li>
          ))}
        </ul>
      </div>
      </div>
    );
}

export default Book
