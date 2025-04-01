package com.game.classes.models.game;

import java.util.Calendar;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.game.classes.models.GameStatus;
import com.game.classes.models.UserData;

@Entity
public class Game {
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	private Long id;

	private String word;
	private String guessedWord;
	private String lettersUsed;
	private int attemptsLeft;
	private int wordNum;
	private Date date;

	@OneToOne(mappedBy = "game")
	private CompletedGame completedGame;

	@ManyToOne
	private UserData userGame;

	public Game() {
	}

	public Game(String word, String guessedWord, int attemptsLeft, int wordNum) {
		super();
		this.word = word;
		this.guessedWord = guessedWord;
		this.setAttemptsLeft(attemptsLeft);
		this.lettersUsed = "";
		this.wordNum = wordNum;
		Calendar today = Calendar.getInstance();
		this.date = today.getTime();
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setLettersUsed(String lettersUsed) {
		this.lettersUsed = lettersUsed;
	}

	public String getLetters() {
		return lettersUsed;
	}

	public void addLetter(String lettersUsed) {
		this.lettersUsed += lettersUsed;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public String getGuessedWord() {
		return guessedWord;
	}

	public void setGuessedWord(String guessedWord) {
		this.guessedWord = guessedWord;
	}

	public int getAttemptsLeft() {
		return attemptsLeft;
	}

	public void setAttemptsLeft(int attemptsLeft) {
		this.attemptsLeft = attemptsLeft;
	}

	public int getWordNum() {
		return wordNum;
	}

	public void setWordNum(int wordNum) {
		this.wordNum = wordNum;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public UserData getUserGame() {
		return userGame;
	}

	public void setUserGame(UserData userGame) {
		this.userGame = userGame;
	}

	public GameStatus getGameState() {
		if (attemptsLeft == 0) {
			return GameStatus.LOST;
		} else if (this.word.equals(this.guessedWord)) {
			return GameStatus.WON;
		}
		return GameStatus.ONGOING;
	}
}
