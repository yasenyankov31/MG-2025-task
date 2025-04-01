package com.game.classes.models.dto;

import java.time.LocalDate;

import com.game.classes.models.UserData;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class UserDto {
	private long id;
	private String username;
	private String password;
	private LocalDate birthDate;
	private Integer age;
	private String role;

	public UserDto(UserData userData) {
		this.id = userData.getId();
		this.username = userData.getUsername();
		this.password = userData.getPassword();
		this.birthDate = userData.getBirthDate();
		this.age = userData.getAge();
	}

}
