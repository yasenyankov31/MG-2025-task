package com.game.classes.models.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserProfileDto {
	private List<Integer> statusValues;
	private int winCount = 0;
	private int lossCount = 0;
}
