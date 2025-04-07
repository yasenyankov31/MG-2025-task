package com.game.classes.models;

import java.time.LocalDate;
import java.util.List;
import java.util.Random;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.game.classes.models.game.Game;

import lombok.Data;

@Entity
@Data
public class UserData {
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	private Long id;
	@NotBlank(message = "Username can't be blank")
	private String username;
	@NotBlank(message = "Password can't be blank")
	private String password;
	@NotNull(message = "Birth date can't be null")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthDate;
	@NotNull(message = "Age can't be null")
	private Integer age;

	private String role;
	@OneToMany(mappedBy = "userGame", cascade = CascadeType.ALL)
	private List<Game> userGame;

	public UserData() {
		Random random = new Random();
		int minDay = (int) LocalDate.of(1900, 1, 1).toEpochDay();
		int maxDay = (int) LocalDate.of(2015, 1, 1).toEpochDay();
		long randomDay = minDay + random.nextInt(maxDay - minDay);

		this.birthDate = LocalDate.ofEpochDay(randomDay);
		this.age = random.nextInt(31) + 20;
		this.password = "password";
	}

	public UserData(@NotBlank(message = "Username can't be blank") String username,
			@NotBlank(message = "Password can't be blank") String password,
			@NotNull(message = "Birth date can't be null") LocalDate birthDate,
			@NotNull(message = "Age can't be null") Integer age, String role) {
		super();
		this.username = username;
		this.password = password;
		this.birthDate = birthDate;
		this.age = age;
		this.role = role;
	}
	public void setUsername(string username) {
		this.username = username;
	}
}
