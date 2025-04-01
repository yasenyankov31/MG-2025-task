package com.game.classes.interfaces.model;

import java.sql.Date;

public interface TopPlayerStats {
	String getUsername();

	int getWinCount();

	int getLostCount();

	Date getFinishDate();
}
