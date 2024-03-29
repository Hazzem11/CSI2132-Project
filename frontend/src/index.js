import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import LogIn from './pages/login/LogIn';
import HotelChains from './pages/HotelChains';




// Rerouting from 1 page to another 

import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";

const router = createBrowserRouter([
  {
    path: "/",
    element: <App/>,
  },
  {
    path: "login",
    element: <LogIn/>,
  },
  {
    path: "hotel-chains",
    element: <HotelChains/>,
  },
]);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <RouterProvider router={router} />
);
<RouterProvider router={router} />