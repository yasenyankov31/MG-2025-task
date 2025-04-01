package com.game.classes.interfaces;

import java.util.List;

import org.springframework.data.domain.Page;

import com.game.classes.models.dto.GameDto;
import com.game.classes.models.game.Game;

public interface GameFactory {
	public GameDto fromEntity(Game game);

	public Page<GameDto> fromEntities(Page<Game> games);

	public List<GameDto> fromEntities(List<Game> games);
}
