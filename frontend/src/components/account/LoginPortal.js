import React, { useState } from "react";
import { Form, Button, Modal } from "react-bootstrap";
import TranslateI18n from "../general/TranslateI18n";

const LoginPortal = () => {
  const [isRegistering, setIsRegistering] = useState(false);
  const [loginUsername, setLoginUsername] = useState("");
  const [loginPassword, setLoginPassword] = useState("");
  const [show, setShow] = useState(false);

  const [registerUsername, setRegisterUsername] = useState("");
  const [registerPassword, setRegisterPassword] = useState("");
  const [registerBirthDate, setRegisterBirthDate] = useState("");

  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);

  const [errorMessage, setErrorMessage] = useState("");

  const switchCard = () => {
    setLoginUsername("");
    setLoginPassword("");

    setRegisterUsername("");
    setRegisterPassword("");
    setRegisterBirthDate("");

    setIsRegistering(!isRegistering);
  };

  const submitLogin = () => {
    if (loginUsername === "" || loginPassword === "") {
      setErrorMessage("Username and password can't be empty!");
      handleShow();
    } else {
      let data = {
        username: loginUsername,
        password: loginPassword,
      };
      fetch("/api/auth/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      })
        .then((response) => {
          if (!response.ok) {
            return response.json().then((err) => {
              throw err;
            });
          }
          response.json().then((data) => {
            localStorage.setItem("username", data.username);
            localStorage.setItem("role", data.role);
            window.location.reload();
          });
        })
        .catch((error) => {
          setErrorMessage(error.message);
          handleShow();
        });
    }
  };

  const submitRegister = () => {
    let data = {
      username: registerUsername,
      password: registerPassword,
      birthDate: registerBirthDate,
    };
    fetch("/api/auth/register", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    })
      .then((response) => {
        if (!response.ok) {
          return response.json().then((err) => {
            throw err;
          });
        }
        response.json().then((data) => {
          localStorage.setItem("username", data.username);
          localStorage.setItem("role", data.role);
          window.location.reload();
        });
      })
      .catch((error) => {
        setErrorMessage(error.message);
        handleShow();
      });
  };

  return (
    <>
      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Something went wrong</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <p className="text-danger text-center p-1">{errorMessage}</p>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={handleClose}>
            Close
          </Button>
        </Modal.Footer>
      </Modal>
      <div className="login-container">
        {!isRegistering ? (
          <div className="login-card">
            <h2 className="login-h2">Login Portal</h2>
            <Form>
              <Form.Group controlId="username">
                <Form.Label>
                  <TranslateI18n id={"UsersTableUsernameColumn"} />
                </Form.Label>
                <Form.Control
                  type="text"
                  value={loginUsername}
                  onChange={(e) => {
                    setLoginUsername(e.target.value);
                  }}
                  placeholder="Enter your username"
                />
              </Form.Group>

              <Form.Group controlId="password">
                <Form.Label>
                  <TranslateI18n id={"UsersTablePasswordColumn"} />
                </Form.Label>
                <Form.Control
                  type="password"
                  value={loginPassword}
                  onChange={(e) => {
                    setLoginPassword(e.target.value);
                  }}
                  placeholder="Enter your password"
                />
              </Form.Group>

              <Button
                className="m-2"
                type="submit"
                onClick={(event) => {
                  event.preventDefault();
                  submitLogin();
                }}
              >
                Login
              </Button>
            </Form>
            <div className="switch">
              Don't have an account?{" "}
              <a href="#" onClick={switchCard}>
                Register here
              </a>
            </div>
          </div>
        ) : (
          <div className="login-card">
            <h2 className="login-h2">Register Portal</h2>
            <Form>
              <Form.Group className="mb-3">
                <Form.Label>
                  <TranslateI18n id={"UsersTableUsernameColumn"} />
                </Form.Label>
                <Form.Control
                  value={registerUsername}
                  onChange={(e) => {
                    setRegisterUsername(e.target.value);
                  }}
                  type="text"
                  placeholder="Your username"
                />
              </Form.Group>

              <Form.Group className="mb-3">
                <Form.Label>
                  <TranslateI18n id={"UsersTablePasswordColumn"} />
                </Form.Label>
                <Form.Control
                  value={registerPassword}
                  onChange={(e) => {
                    setRegisterPassword(e.target.value);
                  }}
                  type="text"
                  placeholder="Your password"
                />
              </Form.Group>
              <Form.Group className="mb-3">
                <Form.Label>
                  <TranslateI18n id={"UsersTableBirthDateColumn"} />
                </Form.Label>
                <Form.Control
                  value={registerBirthDate}
                  onChange={(e) => {
                    setRegisterBirthDate(e.target.value);
                  }}
                  type="date"
                />
              </Form.Group>
              <Button
                className="m-2"
                type="submit"
                onClick={(event) => {
                  event.preventDefault();
                  submitRegister();
                }}
              >
                <TranslateI18n id={"RegisterBtn"} />
              </Button>
            </Form>
            <div className="switch">
              <TranslateI18n id={"DoYouHaveAccount"} />{" "}
              <a href="#" onClick={switchCard}>
                <TranslateI18n id={"LogInHere"} />
              </a>
            </div>
          </div>
        )}
      </div>
    </>
  );
};

export default LoginPortal;
