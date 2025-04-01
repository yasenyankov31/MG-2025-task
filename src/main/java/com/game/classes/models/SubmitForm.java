package com.game.classes.models;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.game.classes.interfaces.CharConstraint;

import lombok.Data;

@Data
public class SubmitForm {
	@NotNull(message = "Game ID must not be blank")
	@NotEmpty(message = "Invalid game id")
	private String gameId;

	@CharConstraint
	@NotNull(message = "Letter must not be null")
	private String letter;
}
