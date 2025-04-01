import React from 'react';
import errorImage from '../../images/error.png'
import { Container, Alert } from 'react-bootstrap';

const NotFound = () => {
  return (
    <Container className="d-flex flex-column justify-content-center align-items-center" style={{ height: '85vh' }}>
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: '1rem' }}>
        <h1 style={{ fontSize: '4rem', marginRight: '0.5rem', paddingTop: '29px' }}>4</h1>
        <img src={errorImage} alt="Error" style={{ width: '100px' }} />
        <h1 style={{ fontSize: '4rem', marginLeft: '0.5rem', paddingTop: '29px' }}>4</h1>
      </div>
      <h1>Page not found</h1>
      <Alert variant="danger" >
        The page you are searching dosen't exist!
      </Alert>
    </Container>
  );
};

export default NotFound;
