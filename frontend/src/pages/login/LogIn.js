import React, { useState } from 'react'
import NavbarNew from '../../components/navbar/NavbarNew'
import person from '../../assets/person.png'
import password from '../../assets/password.png'
import email from '../../assets/email.png'
import './LoginStyles.css';

function LogIn() {
  const [action,setAction] = useState("Sign up")
  return (
    
    <div>
      <NavbarNew />
      <div className='container'>
        <div className="header">
          <div className="text">{action}</div>
        </div>
        <div className="inputs">
        {action==="Login"?<div></div>:<div className="input"> <img src={person} alt=""/> <input type="text" placeholder='Name'/></div>}
          
          <div className="input">
            <img src={email} alt=""/>
            <input type="email" placeholder='Email'/>
          </div>
          <div className="input">
            <img src={password} alt=""/>
            <input type="password" placeholder='Password'/>
          </div>
        </div>
        <div className="submit-container">
          <div className={action==="Login"?"submit gray":"submit"} onClick={()=>{setAction("Sign up")}}>Sign Up</div>
          <div className={action==="Sign up"?"submit gray":"submit"} onClick={()=>{setAction("Login")}}>Log In</div>
        </div>
      </div>
    </div>
  );
}

export default LogIn
