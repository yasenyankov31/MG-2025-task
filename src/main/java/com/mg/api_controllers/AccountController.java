package com.mg.api_controllers;

import java.time.LocalDate;
import java.time.Period;

import javax.validation.Valid;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.game.classes.interfaces.jpa.UserRepository;
import com.game.classes.models.ErrorResponse;
import com.game.classes.models.LoginRequest;
import com.game.classes.models.UserData;
import com.game.classes.models.dto.UserDto;
import com.game.classes.services.UserService;

@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/auth")
public class AccountController {
	@Autowired
	private UserRepository userRepository;

	@Autowired
	private UserService userService;

	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
		Subject subject = SecurityUtils.getSubject();
		var userOptional = userRepository.findByUsername(loginRequest.getUsername());

		if (userOptional.isEmpty()) {
			throw new IllegalArgumentException("User doesn't exist!");
		}

		UserData user = userOptional.get();
		if (!user.getPassword().equals(loginRequest.getPassword())) {
			throw new IllegalArgumentException("Password doesn't match!");
		}

		if (!subject.isAuthenticated()) {
			UsernamePasswordToken token = new UsernamePasswordToken(loginRequest.getUsername(),
					loginRequest.getPassword());
			subject.login(token);

			UserDto response = new UserDto();
			response.setUsername(user.getUsername());
			response.setRole(user.getRole());

			return ResponseEntity.ok(response);
		} else {
			throw new IllegalArgumentException("Already logged in");
		}
	}

	@PostMapping("/register")
	public ResponseEntity<?> register(@Valid @RequestBody UserDto userDto, BindingResult result) {
		Subject subject = SecurityUtils.getSubject();
		LocalDate currentDate = LocalDate.now();
		int age = Period.between(userDto.getBirthDate(), currentDate).getYears();

		if (age <= 0) {
			throw new IllegalArgumentException("User date of birth is invalid!");
		}
		if (result.hasErrors()) {
			throw new IllegalArgumentException("User formdata is invalid!");
		}
		if (!userService.checkIfUserExist(userDto.getUsername())) {
			throw new IllegalArgumentException("User with this name already exists!");
		}

		UserData user = new UserData(userDto.getUsername(), userDto.getPassword(), userDto.getBirthDate(), age,
				userDto.getRole());
		user.setUsername(userDto.getUsername());
		user.setPassword(userDto.getPassword());
		user.setAge(age);
		user.setRole("user");

		userService.createUser(user);

		UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(), user.getPassword());
		subject.login(token);
		user.setPassword("");

		return ResponseEntity.ok(userDto);
	}

	@PostMapping("/logout")
	public ResponseEntity<?> logout() {
		Subject subject = SecurityUtils.getSubject();

		if (subject.isAuthenticated()) {
			subject.logout();
			return ResponseEntity.ok("Logged out successfully");
		} else {
			throw new IllegalArgumentException("Not logged in");
		}
	}

	@ExceptionHandler(IllegalArgumentException.class)
	public ResponseEntity<ErrorResponse> handleIllegalArgumentException(IllegalArgumentException ex) {
		ErrorResponse errorResponse = new ErrorResponse("Bad request", ex.getMessage());
		return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
	}

}
