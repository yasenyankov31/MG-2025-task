package com.mg;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.game.classes.interfaces.CharConstraint;

public class CharValidator implements ConstraintValidator<CharConstraint, Object> {

  @Override
  public void initialize(CharConstraint constraintAnnotation) {
    // Initialization, if needed
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    // Check if the value is not a string
    int size = value.toString().length();
    return size == 1;
  }
}
