package com.mg;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(Exception.class)
	protected ResponseEntity<String> validate(Exception ex) {
		return new ResponseEntity<>("Something went wrong " + ex.getMessage(), HttpStatus.OK);
	}
}
