package com.game.classes.models.dto;

import java.util.Date;

import com.game.classes.models.GameStatus;
import com.game.classes.models.game.Game;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GameDto {
	private Long id;
	private String guessedWord;
	private String lettersUsed;
	private int attemptsLeft;
	private int wordNum;
	private Date date;
	private GameStatus gameStatus;
	private boolean isCompletedGame;
	private String originalWord;

	public GameDto(Game game) {
		this.id = game.getId();
		this.guessedWord = game.getGuessedWord();
		this.lettersUsed = game.getLetters();
		this.attemptsLeft = game.getAttemptsLeft();
		this.wordNum = game.getWordNum();
		this.date = game.getDate();
		this.gameStatus = game.getGameState();
	}

}
