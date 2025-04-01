package com.game.classes.services;

import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.game.classes.interfaces.jpa.GameRepository;
import com.game.classes.interfaces.jpa.UserRepository;
import com.game.classes.models.game.Game;

@Service
public class GameService {

	@Autowired
	private GameRepository gameRepository;

	@Autowired
	private UserRepository userRepository;

	private Random random;

	public GameService() {
		this.random = new Random();
	}

	public String getRandomWord() {
		return "word";
	}

	public Game createNewGame() {
		Game game = createGame();
		gameRepository.save(game);
		return game;
	}

	private Game createGame() {
		Subject subject = SecurityUtils.getSubject();
		var wordAndNum = getRandomWord().split(" ");
		String word = wordAndNum[0];
		StringBuilder guessedWord = new StringBuilder();
		char first = word.charAt(0);
		char last = word.charAt(word.length() - 1);
		guessedWord.append(first);
		for (int i = 1; i < word.length() - 1; i++) {
			if (word.charAt(i) == first || word.charAt(i) == last) {
				guessedWord.append(word.charAt(i));
			} else {
				guessedWord.append("*");
			}
		}
		guessedWord.append(last);
		Game game = new Game(word, guessedWord.toString(), 8, Integer.parseInt(wordAndNum[1]));
		var userOptional = userRepository.findByUsername((String) subject.getPrincipal());
		if (userOptional.isPresent()) {
			game.setUserGame(userOptional.get());
		}
		return game;
	}

	public Game guessLetter(long gameId, char letter) {
		Optional<Game> optionalGame = gameRepository.findById(gameId);
		if (!optionalGame.isPresent()) {
			return null;
		}

		Game game = optionalGame.get();

		String word = game.getWord();
		String guessedWord = game.getGuessedWord();
		int attemptsLeft = game.getAttemptsLeft();

		letter = Character.toLowerCase(letter);

		game.addLetter("" + letter);

		if (word.indexOf(letter) == -1) {
			attemptsLeft--;
		}

		StringBuilder newGuessedWord = new StringBuilder();
		var guessArr = guessedWord.toCharArray();
		var wordArr = word.toCharArray();
		for (int i = 0; i < word.length(); i++) {
			if (wordArr[i] == letter) {
				newGuessedWord.append(wordArr[i]);
			} else {
				newGuessedWord.append(guessArr[i]);
			}
		}

		game.setGuessedWord(newGuessedWord.toString());
		game.setAttemptsLeft(attemptsLeft);
		gameRepository.save(game);

		return game;
	}

	public Game getGameState(long gameId) {
		return gameRepository.findById(gameId).get();
	}

	public String getUsersLetters(long gameId) {
		Game game = gameRepository.findById(gameId).get();
		return game.getLetters();
	}

	public Game resetGame(long gameId) {

		Game currentGame = gameRepository.findById(gameId).get();
		if (currentGame != null) {
			Game newGame = createGame();
			newGame.setId(currentGame.getId());
			newGame.setWordNum(newGame.getWordNum());
			gameRepository.save(newGame);
		}
		return currentGame;
	}

	public Page<Game> getUnfinishedGames(int pageNum) {
		Long userId = 0L;
		Subject subject = SecurityUtils.getSubject();
		var userOptional = userRepository.findByUsername((String) subject.getPrincipal());
		if (userOptional.isPresent()) {
			userId = userOptional.get().getId();
		}
		PageRequest pageable = PageRequest.of(pageNum, 5);
		return gameRepository.getUnfinishedGames(userId, pageable);
	}

	public List<Game> getUnfinishedGames() {
		return gameRepository.getUnfinishedGames();
	}

	public boolean checkIfGameIsCompleted(long gameId) {
		return gameRepository.checkIfGameIsCompleted(gameId);
	}
}
