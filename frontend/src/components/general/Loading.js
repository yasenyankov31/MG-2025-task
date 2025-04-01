import React, { useState, useEffect } from 'react';
import { Container } from 'react-bootstrap';
import '../../css/Loading.css'

const Loading = () => {
  const [show, setShow] = useState(true);

  useEffect(() => {
    const timer = setInterval(() => {
      setShow((prevShow) => !prevShow);
    }, 1000);

    return () => {
      clearInterval(timer);
    };
  }, []);

  return (
    <Container className="d-flex align-items-center justify-content-center vh-100">   
        <div className="hourglass"></div>
    </Container>
  );
};

export default Loading;
