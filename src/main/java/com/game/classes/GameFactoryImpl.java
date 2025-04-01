package com.game.classes;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.stereotype.Component;

import com.game.classes.interfaces.GameFactory;
import com.game.classes.models.dto.GameDto;
import com.game.classes.models.game.Game;

@Component
public class GameFactoryImpl implements GameFactory {

	@Override
	public GameDto fromEntity(Game game) {
		return new GameDto(game);
	}

	@Override
	public Page<GameDto> fromEntities(Page<Game> games) {
		List<GameDto> gameDtos = new ArrayList<>();
		for (Game gameData : games.getContent()) {
			gameDtos.add(new GameDto(gameData));
		}
		return new PageImpl<>(gameDtos, games.getPageable(), games.getTotalElements());
	}

	@Override
	public List<GameDto> fromEntities(List<Game> games) {
		List<GameDto> gameDtos = new ArrayList<>();
		for (Game gameData : games) {
			gameDtos.add(new GameDto(gameData));
		}
		return gameDtos;
	}

}
