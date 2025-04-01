import "./App.css";
import React, { useState } from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import { SWRConfig } from "swr";
import "bootstrap/dist/css/bootstrap.min.css";
import Home from "./components/statistics/Home";
import Game from "./components/games/Game";
import Games from "./components/games/Games";
import ParentNavbar from "./components/general/ParentNavbar";
import User from "./components/users/User";
import Users from "./components/users/Users";
import NotFound from "./components/general/NotFound";
import LoginPortal from "./components/account/LoginPortal";

const fetcher = async (url) => {
  const response = await fetch(url);
  if (!response.ok) {
    const errorData = await response.json();
    throw new Error(errorData.message);
  }
  return response.json();
};

function MainRoutes() {
  return (
    <div>
      <ParentNavbar />
      <Routes>
        <Route exact path="/" element={<Home />} />
        <Route path="/game/:id" element={<Game />} />
        <Route path="/games/:page" element={<Games />} />
        <Route path="/user/:username/:page" element={<User />} />
        <Route path="/users/:page" element={<Users />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </div>
  );
}

function App() {
  const [isUnauthorized, setUnauthorized] = useState(false);

  if (isUnauthorized) {
    return <LoginPortal />;
  }

  return (
    <SWRConfig
      value={{
        fetcher,
        onError: (error) => {
          if (error.message === "User is not authenticated") {
            setUnauthorized(true);
          }
        },
      }}
    >
      <Router>
        <MainRoutes />
      </Router>
    </SWRConfig>
  );
}

export default App;
