import React, { useState } from "react";
import BookingNavbar from "./BookingNavbar";
import { useParams } from "react-router-dom";
import "./BookingStyling.css";
import Video from "../../assets/cool-hotel.mp4";

function Book() {
  // State variables to store form input values and fetched rooms
  const { hotel_address } = useParams(); // Get hotel_address from URL params

  const [rooms, setRooms] = useState([]);
  const [formData, setFormData] = useState({
    startDate: "",
    endDate: "",
    roomCapacity: "",
    roomPrice: "",
  });

  // Function to handle form submission
  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      // Make GET request to backend API with form data
      const response =
        await fetch(`http://localhost:3001/rooms?startDate=${formData.startDate}
        &endDate=${formData.endDate}
        &roomCapacity=${formData.roomCapacity}
        &hotel_address=${hotel_address}
        &roomPrice=${formData.roomPrice}
        `);

      const data = await response.json();

      setRooms(data.rooms); // Update rooms state with fetched rooms

      // Clear the form data after successful submission
      setFormData({
        startDate: "",
        endDate: "",
        roomCapacity: "",
        roomPrice: "",
      });
    } catch (error) {
      console.error("Error fetching rooms:", error);
      // Handle errors
    }
  };

  // Function to handle input changes
  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
  };

  return (
    <div className="booking">
      <video autoPlay loop muted id="video">
        <source src={Video} type="video/mp4" />
      </video>
      <BookingNavbar />
      <div className="overlay"></div>
      <div className="search">
        <form className="form" onSubmit={handleSubmit}>
          <div>
            <label htmlFor="startDate">Start Date:</label>
            <input
              type="date"
              id="startDate"
              name="startDate"
              value={formData.startDate}
              onChange={handleInputChange}
            />
          </div>
          <div>
            <label htmlFor="endDate">End Date:</label>
            <input
              type="date"
              id="endDate"
              name="endDate"
              value={formData.endDate}
              onChange={handleInputChange}
            />
          </div>
          <div>
            <label htmlFor="roomCapacity">Room Capacity:</label>
            <input
              type="number"
              id="roomCapacity"
              name="roomCapacity"
              value={formData.roomCapacity}
              onChange={handleInputChange}
            />
          </div>
          <div>
            <label htmlFor="roomPrice">Room Price:</label>
            <input
              type="number"
              id="roomPrice"
              name="roomPrice"
              value={formData.roomPrice}
              onChange={handleInputChange}
            />
          </div>
          <button type="submit">Search</button>
        </form>
      </div>
      <div className="room-view">
        <h1>{hotel_address}</h1>
        <ul>
          {rooms.map((room) => (
            <li key={room.room_number}>
              Room Number: {room.room_number}, {room.capacity}, {room.price}
              {/* <button onClick={() => handleBookRooms(hotel.hotel_address)}>View Rooms</button> */}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default Book;
