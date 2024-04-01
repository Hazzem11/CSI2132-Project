import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import LogIn from './pages/login/LogIn';
import Book from './pages/booking/book';
import Profile from './pages/profile/Profile';
import BookingToRenting from './pages/bookingToRenting/BookingToRenting';



// Rerouting from 1 page to another 

import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";

const router = createBrowserRouter([
  {
    path: "/",
    element: <LogIn/>,
  },
  {
    path: "/home",
    element: <App/>,
  },
  {
    path: "booking",
    element: <Book/>,
  },
  {
    path: "booking/:employee_full_name/:hotel_address",
    element: <Book/>,
  },
  {
    path: "profile",
    element: <Profile/>,
  },
  {
    path: "booking-to-renting",
    element: <BookingToRenting/>,
  },
]);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <RouterProvider router={router} />
);
<RouterProvider router={router} />