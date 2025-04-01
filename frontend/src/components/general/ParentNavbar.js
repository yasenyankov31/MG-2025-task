import React, { useEffect } from "react";
import { Link } from "react-router-dom";
import { Navbar, Nav, Button } from "react-bootstrap";
import Select, { components } from "react-select"; // Import components from react-select
import { useTranslation } from "react-i18next";
import { Translate } from "react-bootstrap-icons";
import TranslateI18n from "./TranslateI18n";

const ParentNavbar = () => {
  const { i18n } = useTranslation();

  useEffect(() => {
    i18n.changeLanguage("en"); // set default language to English
  }, [i18n]);

  const logOut = () => {
    fetch("/api/auth/logout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then(() => {
        localStorage.setItem("role", null);
        localStorage.setItem("username", null);
        window.location.reload();
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const languageOptions = [
    { value: "en", label: "English" },
    { value: "bg", label: "Български" },
    // Add more languages as needed
  ];

  const currentLanguageOption = languageOptions.find(
    (option) => option.value === i18n.language
  );

  const DropdownIndicator = (props) => {
    return (
      <components.DropdownIndicator {...props}>
        <Translate />
      </components.DropdownIndicator>
    );
  };

  return (
    <>
      <Navbar bg="dark" variant="dark" expand="lg" className="px-5" fixed="top">
        <Navbar.Brand as={Link} to="/" className="fs-3">
          <TranslateI18n id={"NavTitle"} />
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="navbarScroll" />
        <Navbar.Collapse id="navbarScroll">
          <Nav
            className="mr-auto my-2 my-lg-0 flex-grow-1"
            style={{ maxHeight: "100px" }}
            navbarScroll
          >
            <Nav.Link as={Link} to="/games/1" className="nav-link">
              <TranslateI18n id={"NavGames"} />
            </Nav.Link>
            {localStorage.getItem("role") === "admin" && (
              <Nav.Link as={Link} to="/users/1" className="nav-link">
                <TranslateI18n id={"NavUsers"} />
              </Nav.Link>
            )}
          </Nav>

          <div className="ml-auto d-flex align-items-center">
            <Select
              components={{ DropdownIndicator }}
              options={languageOptions}
              defaultValue={currentLanguageOption}
              onChange={(selectedOption) =>
                i18n.changeLanguage(selectedOption.value)
              }
            />
            <Button
              style={{ marginLeft: "15px" }}
              onClick={() => {
                logOut();
              }}
            >
              <TranslateI18n id={"LogOutBtn"} />
            </Button>
          </div>
        </Navbar.Collapse>
      </Navbar>
    </>
  );
};

export default ParentNavbar;
