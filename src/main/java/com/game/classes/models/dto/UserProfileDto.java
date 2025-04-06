package com.game.classes.models.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserProfileDto {
	private List<Integer> statusValues;
	private int winCount;
	private int lossCount;

	public UserProfileDto(List<Integer> statusValues, int winCount, int lossCount) {
		this.statusValues = statusValues;
		this.winCount = winCount;
		this.lossCount = lossCount;
	}

	public List<Integer> getStatusValues() {
		return statusValues;
	}

	public int getWinCount() {
		return winCount;
	}

	public int getLossCount() {
		return lossCount;
	}
}