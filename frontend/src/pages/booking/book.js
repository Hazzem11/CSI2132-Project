import React, { useState } from "react";
import BookingNavbar from "./BookingNavbar";
import EmployeeNavbar from "../../components/navbar/EmployeeNavbar";
import { useParams } from "react-router-dom";
import "./BookingStyling.css";
import Video from "../../assets/cool-hotel.mp4";

function Book() {
  let purpose = ""
  const [fullName, setFullName] = useState("");
  const [rooms, setRooms] = useState([]);
  const [formData, setFormData] = useState({
    startDate: "",
    endDate: "",
    roomCapacity: "",
    roomPrice: "",
  });
  const [showBookingForm, setShowBookingForm] = useState(false);
  const [selectedRoomId, setSelectedRoomId] = useState(null);
  const { employee_full_name,hotel_address } = useParams();
  console.log(employee_full_name);
  console.log(hotel_address);
  if (employee_full_name === undefined) {
    purpose = "Book Room";
  } else {
    purpose = "Rent Room";
  }
  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch(`http://localhost:3001/rooms?startDate=${formData.startDate}
        &endDate=${formData.endDate}
        &roomCapacity=${formData.roomCapacity}
        &hotel_address=${hotel_address}
        &roomPrice=${formData.roomPrice}`);

      const data = await response.json();
      console.log(data);
      setRooms(data.rooms);
      
    } catch (error) {
      console.error("Error fetching rooms:", error);
    }
  };
  const handleBookingSubmit = async (event) => {
  
    try {
      if (purpose === "Book Room"){
        const response2 = await fetch('http://localhost:3001/booking', {
      method: 'POST',
     headers: {
    'Content-Type': 'application/json',
      },
    body: JSON.stringify({
    booking_start_date: formData.startDate,
    booking_end_date: formData.endDate,
    customer_full_name: fullName,
    hotel_address: hotel_address,
    room_number: selectedRoomId
     }),
    });
      }
      else{
        console.log("AAAAAAAAAAAAAAAAAAAAAAAAAAA")
        console.log(fullName)
        
console.log("Parameter values:", [
  formData.startDate,
  formData.endDate,
  fullName,
  hotel_address,
  selectedRoomId,
  employee_full_name
]);
        const response2 = await fetch('http://localhost:3001/renting', {
      method: 'POST',
     headers: {
    'Content-Type': 'application/json',
      },
    body: JSON.stringify({
    booking_start_date: formData.startDate,
    booking_end_date: formData.endDate,
    customer_full_name: fullName,
    hotel_address: hotel_address,
    room_number: selectedRoomId,
    employee_full_name : employee_full_name
     }),
    });
      }
      setShowBookingForm(false);
      setSelectedRoomId(null);
    } catch (error) {
      console.error("Error fetching rooms:", error);
    }
  };

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleButtonClick = (roomId) => {
    setShowBookingForm(true);
    setSelectedRoomId(roomId);
  };

  

  return (
    <div className="booking">
      <video autoPlay loop muted id="video">
        <source src={Video} type="video/mp4" />
      </video>
      {employee_full_name === undefined ? <BookingNavbar /> : <EmployeeNavbar />}
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
              Room Number: {room.room_number}, {room.capacity} people, ${room.price}
              <button onClick={() => handleButtonClick(room.room_number)}>{purpose}</button>
              {showBookingForm && selectedRoomId === room.room_number && (
                <div>
                <input
                  type="text"
                  placeholder="Enter Full Name"
                  value={fullName}
                  onChange={(e) => setFullName(e.target.value)}
                />
                <button onClick={() => handleBookingSubmit(fullName)}>Submit</button>
              </div>
              )}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default Book;