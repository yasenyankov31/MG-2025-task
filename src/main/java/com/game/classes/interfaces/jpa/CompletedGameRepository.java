package com.game.classes.interfaces.jpa;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.game.classes.interfaces.model.TopPlayerStats;
import com.game.classes.interfaces.model.UserRankData;
import com.game.classes.models.game.CompletedGame;

@Repository
public interface CompletedGameRepository extends CrudRepository<CompletedGame, Long> {
	@Query("SELECT ud.username as username, " + "SUM(CASE WHEN cg.gameStatus = 'Won' THEN 1 ELSE 0 END) AS winCount, "
			+ "SUM(CASE WHEN cg.gameStatus = 'Lost' THEN 1 ELSE 0 END) AS lostCount,cg.finishDate "
			+ "FROM CompletedGame cg "
			+ "JOIN RankingPerGamer rpg ON rpg.id = cg.rankingPerGamer AND cg.finishDate >= :date "
			+ "JOIN UserData ud ON ud.id = rpg.userData " + "GROUP BY ud.username " + "ORDER BY winCount DESC")
	List<TopPlayerStats> findTop10(Date date, Pageable pageable);

	@Query("SELECT cg.gameStatus as gameStatus,g.word as word,g.lettersUsed as lettersUsed,g.attemptsLeft as attemptsLeft,g.date as startDate "
			+ "FROM CompletedGame cg " + "JOIN RankingPerGamer rpg ON rpg.id = cg.rankingPerGamer "
			+ "JOIN UserData ud ON ud.id = rpg.userData "
			+ "JOIN Game g ON g.id = cg.game WHERE ud.username = :username ORDER BY cg.finishDate ")
	Page<UserRankData> userProfileData(String username, Pageable pageable);
}
