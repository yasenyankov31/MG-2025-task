import React, { useState, useEffect } from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";
import { Container } from "react-bootstrap";
import TranslateI18n from "../general/TranslateI18n";

function UserModal({
  show,
  closeModal,
  userData,
  updateUsers,
  isDeleting,
  deleteIds,
}) {
  const [userId, setUserId] = useState(0);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [birthDate, setBirthDate] = useState("");

  const [action, setAction] = useState("Add");
  const [deleteParams, setDeleteParams] = useState("");
  const [deleteMessage, setDeleteMessage] = useState(
    "Are you sure you want to delete?"
  );

  const [executionStatus, setExecutionStatus] = useState("");

  const actions = {
    Add: "POST",
    Edit: "PUT",
    Delete: "DELETE",
  };

  const submitModal = () => {
    fetch("/api/users" + deleteParams, {
      method: actions[action],
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        id: userId,
        username: username,
        password: password,
        birthDate: birthDate,
      }),
    })
      .then((response) => response.json())
      .then((successMessage) => {
        setAction("Processed");
        setExecutionStatus(successMessage.message);
        updateUsers();
      })
      .catch((errorMessage) => {
        setAction("Processed");
        setExecutionStatus(errorMessage.message);
      });

    setDeleteParams("");
  };
  useEffect(() => {
    setDeleteParams("");
  }, [deleteIds]);

  useEffect(() => {
    if (isDeleting) {
      setAction("Delete");
      if (deleteIds.size !== 0) {
        let params = "?";
        for (let value of deleteIds) {
          params += deleteParams + "ids=" + value + "&";
        }
        setDeleteParams(params.slice(0, -1));

        setDeleteMessage("ModalDeleteWarning");
      } else {
        setDeleteMessage("ModalDeleteException");
      }
    } else if (userData === null) {
      setAction("Add");
      setUsername("");
      setPassword("");
      setBirthDate("");
    } else {
      setAction("Edit");
      setUserId(userData.id || 0);
      setUsername(userData.username || "");
      setPassword(userData.password || "");
      setBirthDate(userData.birthDate || "");
    }
  }, [show]);

  const renderModalBody = () => {
    switch (action) {
      case "Add":
      case "Edit":
        return (
          <>
            <Modal.Body>
              <Form>
                <Form.Group className="mb-3">
                  <Form.Label>
                    <TranslateI18n id={"UsersTableUsernameColumn"} />
                  </Form.Label>
                  <Form.Control
                    id="usernameInput"
                    defaultValue={username}
                    onChange={(e) => {
                      setUsername(e.target.value);
                    }}
                    type="text"
                    placeholder="ProPlayer123"
                  />
                </Form.Group>

                <Form.Group className="mb-3">
                  <Form.Label>
                    <TranslateI18n id={"UsersTablePasswordColumn"} />
                  </Form.Label>
                  <Form.Control
                    id="passwordInput"
                    defaultValue={password}
                    onChange={(e) => {
                      setPassword(e.target.value);
                    }}
                    type="text"
                    placeholder="Original password"
                  />
                </Form.Group>

                <Form.Group className="mb-3">
                  <Form.Label>
                    <TranslateI18n id={"UsersTableBirthDateColumn"} />
                  </Form.Label>
                  <Form.Control
                    id="dateInput"
                    defaultValue={birthDate}
                    onChange={(e) => {
                      setBirthDate(e.target.value);
                    }}
                    type="date"
                  />
                </Form.Group>
              </Form>
            </Modal.Body>
            <Modal.Footer className="justify-content-start">
              <Button
                id="sendButton"
                data-testid="edit"
                variant="primary"
                onClick={submitModal}
              >
                <TranslateI18n id={"ModalTitle" + action} />
              </Button>
            </Modal.Footer>
          </>
        );
      case "Delete":
        return (
          <div
            className="d-flex justify-content-center align-items-center"
            style={{ marginTop: "50px", marginBottom: "50px" }}
          >
            <Container className="text-center">
              <h5 className="btn-danger">
                <TranslateI18n id={deleteMessage} />
              </h5>
              {deleteIds.size > 0 && (
                <Button className="btn-danger" onClick={submitModal}>
                  <TranslateI18n id={"ModalTitleDelete"} />
                </Button>
              )}
            </Container>
          </div>
        );
      case "Processed":
        return (
          <div
            className="d-flex justify-content-center align-items-center"
            style={{ marginTop: "50px", marginBottom: "50px" }}
          >
            <h5 id="successMessage" className="text-center text-success">
              {executionStatus}
            </h5>
          </div>
        );
      default:
        return null;
    }
  };

  return (
    <>
      <Modal show={show} onHide={closeModal}>
        <Modal.Header closeButton>
          <Modal.Title>
            <TranslateI18n id={"ModalTitle" + action} />
          </Modal.Title>
        </Modal.Header>

        {renderModalBody()}
      </Modal>
    </>
  );
}

export default UserModal;
