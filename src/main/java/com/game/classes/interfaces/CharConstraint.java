package com.game.classes.interfaces;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

import com.mg.CharValidator;

@Documented
@Constraint(validatedBy = CharValidator.class)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface CharConstraint {

  String message() default "Character must be provided";

  Class<?>[] groups() default {};

  Class<? extends Payload>[] payload() default {};
}
