import React from 'react';

function RoomAvailability({ availableRooms }) {
  return (
    <div className="availability">
      {availableRooms > 0 ? `${availableRooms} room available` : 'No rooms available'}
    </div>
  );
}

export default RoomAvailability;
