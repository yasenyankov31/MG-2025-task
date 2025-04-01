package com.game.classes;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.stereotype.Component;

import com.game.classes.interfaces.UserFactory;
import com.game.classes.models.UserData;
import com.game.classes.models.dto.UserDto;

@Component
public class UserFactoryImpl implements UserFactory {

	@Override
	public UserDto fromEntity(UserData user) {
		return new UserDto(user);
	}

	@Override
	public Page<UserDto> fromEntities(Page<UserData> users) {
		List<UserDto> userDtos = new ArrayList<>();
		for (UserData userData : users.getContent()) {
			userDtos.add(new UserDto(userData));
		}
		return new PageImpl<>(userDtos, users.getPageable(), users.getTotalElements());
	}
}
