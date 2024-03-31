import React, {Fragment, useState} from 'react'
import Video from '../../assets/cool-hotel.mp4';
import EmployeeNavbar from '../../components/employeeNavbar/EmployeeNavbar';
// List all current bookings and allow employee to search
// For bookings under a customers name


function CreateRent() {
  const [customerName, setCustomerName] = useState("");
  console.log(customerName);
  const onSubmitForm = async (e) => {
      e.preventDefault();
  }
  return ( <div className='hero'>
    <EmployeeNavbar/>
  <video autoPlay loop muted id='video'>
    <source src={Video} type='video/mp4' />
  </video>
  <div className='overlay'></div>
  <div className="search">
    <form className="form" onSubmit={onSubmitForm}>
      <div>
      </div> 
      <div>
      </div>
      <button type="submit">Create</button>
    </form>
  </div>
  <div className='hotel-view'>
<h1>Available Rooms</h1>
</div>

</div> 
);
}

export default CreateRent

