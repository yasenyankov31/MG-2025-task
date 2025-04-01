package com.game.classes.interfaces.jpa;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.game.classes.models.game.Game;

@Repository
public interface GameRepository extends JpaRepository<Game, Long> {
	@Query("SELECT g FROM Game g LEFT JOIN g.completedGame cg " + "WHERE g.userGame.id = :userId AND cg.id IS NULL "
			+ "ORDER BY g.id ASC")
	Page<Game> getUnfinishedGames(@Param("userId") Long userId, Pageable pageable);

	@Query("SELECT g FROM Game g")
	Page<Game> getUnfinishedGames(Pageable pageable);

	@Query("SELECT g FROM Game g")
	List<Game> getUnfinishedGames();

	@Query("SELECT COUNT(cg) > 0 FROM CompletedGame cg WHERE cg.game.id = :gameId")
	boolean checkIfGameIsCompleted(@Param("gameId") long gameId);
}
