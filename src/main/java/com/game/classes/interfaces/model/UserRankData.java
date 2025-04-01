package com.game.classes.interfaces.model;

import java.util.Date;

public interface UserRankData {
	String getGameStatus();

	String getWord();

	String getLettersUsed();

	int getAttemptsLeft();

	Date getStartDate();
}
