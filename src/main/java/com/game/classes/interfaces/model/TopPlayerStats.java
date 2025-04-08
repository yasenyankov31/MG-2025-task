package com.game.classes.interfaces.model;

import java.sql.Date;

public interface TopPlayerStats {
	String getUsername();

	Long getWinCount();

	Long getLostCount();

	Date getFinishDate();
}
