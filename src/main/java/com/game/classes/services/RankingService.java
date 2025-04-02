package com.game.classes.services;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.game.classes.interfaces.jpa.CompletedGameRepository;
import com.game.classes.interfaces.jpa.UserRepository;
import com.game.classes.interfaces.model.UserRankData;
import com.game.classes.models.GameStatus;
import com.game.classes.models.UserData;
import com.game.classes.models.game.CompletedGame;
import com.game.classes.models.game.Game;
import com.game.classes.models.game.RankingData;
import com.game.classes.models.game.RankingPerGamer;

@Service
public class RankingService {
	@Autowired
	private CompletedGameRepository completedGameRepository;

	@Autowired
	private UserRepository userRepository;

	UserData checkIfUserExist(String username) {
		List<UserData> users = userRepository.findAllByUsername(username);

		if (users.isEmpty()) {
			UserData newUser = new UserData();
			newUser.setUsername(username);
			userRepository.save(newUser);
			return newUser;
		}
		return users.get(0);
	}

	public void completeGame(Game game, String username) {
		GameStatus gameResultState = game.getGameState();
		UserData user = checkIfUserExist(username);
		CompletedGame completedGame = new CompletedGame(gameResultState.toString(), game);
		RankingPerGamer statistic = new RankingPerGamer(user, completedGame);
		// rankingRepository.save(statistic);
		completedGame.setRankingPerGamer(statistic);
		completedGameRepository.save(completedGame);
	}

	public RankingData topTenOfTheMonth() {
		RankingData monthData = new RankingData();
	
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_MONTH, 0);
		Date startOfMonth = calendar.getTime();

		Pageable pageable = PageRequest.of(0, 10);
	
		completedGameRepository.findTop10(startOfMonth, pageable).forEach(item -> {
			monthData.getUserNames().add(item.getUsername());
			monthData.getWinCounts().add(item.getWinCount());
		});
	
		return monthData;
	}
	
	public RankingData topTenOfAllTime() {
		RankingData allTimeData = new RankingData();
	
		Date veryOldDate = new Date(0);
	
		Pageable pageable = PageRequest.of(0, 10);
	
		completedGameRepository.findTop10(veryOldDate, pageable).forEach(item -> {
			allTimeData.getUserNames().add(item.getUsername());
			allTimeData.getWinCounts().add(item.getWinCount());
		});
	
		return allTimeData;
	}
	

	public Page<UserRankData> getUserInfo(String username, Integer pageNum) {
		if (pageNum == null) {
			return completedGameRepository.userProfileData(username, null);
		}
		Pageable pageable = PageRequest.of(pageNum, 5);

		return completedGameRepository.userProfileData(username, pageable);
	}
}
