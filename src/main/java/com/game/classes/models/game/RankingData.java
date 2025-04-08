package com.game.classes.models.game;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class 	RankingData {
	private List<String> userNames = new ArrayList<>();
	private List<Long> winCounts = new ArrayList<>();
}
