import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import LogIn from './pages/login/LogIn';
import Book from './pages/booking/book';
import Profile from './pages/profile/Profile';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

ReactDOM.render(
  <Router>
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="/login" element={<LogIn />} />
      <Route path="/booking" element={<Book />} />
      <Route path="/profile" element={<Profile />} />
      <Route path="/booking/:hotel_address" element={<Book />} />

    </Routes>
  </Router>,
  document.getElementById('root')
);
