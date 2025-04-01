package com.game.classes.models.game;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.game.classes.models.UserData;

import lombok.Data;

@Entity
@Data
public class RankingPerGamer {
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	private long id;

	@OneToOne
	private UserData userData;

	@OneToMany(mappedBy = "rankingPerGamer", cascade = CascadeType.ALL)
	private List<CompletedGame> completedGames = new ArrayList<>();

	public RankingPerGamer(UserData userData, CompletedGame completedGame) {
		super();
		this.userData = userData;
		this.completedGames.add(completedGame);
	}
}
