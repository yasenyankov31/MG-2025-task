package com.game.classes.models.game;

import java.util.Calendar;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import lombok.Data;

@Entity
@Data
public class CompletedGame {
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	private Long id;

	private String gameStatus;

	@OneToOne
	private Game game;

	@ManyToOne
	private RankingPerGamer rankingPerGamer;

	private Date finishDate;

	public CompletedGame(String gameStatus, Game game) {
		super();
		this.game = game;
		this.gameStatus = gameStatus;
		Calendar today = Calendar.getInstance();
		this.finishDate = today.getTime();
	}
	public void setRankingPerGamer(RankingPerGamer rpg) {
		this.rankingPerGamer = rpg;
	}
}
