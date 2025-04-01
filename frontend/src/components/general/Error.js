import React from 'react';
import errorImage from '../../images/error.png'
import { Container, Alert } from 'react-bootstrap';

const Error = ({ message }) => {
    return (
      <Container className="d-flex flex-column justify-content-center align-items-center" style={{ height: '85vh' }}>
        <div style={{ display: 'flex', alignItems: 'center', marginBottom: '1rem' }}>
          <h1 style={{ fontSize: '4rem', marginRight: '0.5rem' ,paddingTop: '29px'}}>5</h1>
          <img src={errorImage} alt="Error" style={{ width: '100px' }} />
          <h1 style={{ fontSize: '4rem', marginLeft: '0.5rem' ,paddingTop: '29px'}}>0</h1>
        </div>
        <h1>Something went wrong</h1>
        <Alert variant="danger" >
          {message}
        </Alert>
      </Container>
    );
  };
  
  export default Error;
