package com.game_classes;

import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.testng.Assert.assertEquals;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import com.game.classes.interfaces.jpa.UserRepository;
import com.game.classes.models.UserData;
import com.game.classes.services.UserService;

@RunWith(MockitoJUnitRunner.class)
public class UserServiceTest {

	@Mock
	private UserRepository userRepository;

	@InjectMocks
	private UserService userService;

	@BeforeEach
	public void setup() {
		MockitoAnnotations.openMocks(this);
	}

	@Test
	public void testCreateOrUpdateUser() {
		UserData user = new UserData();

		userService.createUser(user);

		verify(userRepository, times(1)).save(user);
	}

	@Test
	public void testListAllUsers() {
		int pageNum = 0;
		int pageSize = 5;
		PageRequest pageable = PageRequest.of(pageNum, pageSize);
		List<UserData> userList = new ArrayList<>();
		Page<UserData> expectedPage = new PageImpl<>(userList, pageable, userList.size());

		when(userRepository.findAll(pageable)).thenReturn(expectedPage);

		Page<UserData> resultPage = userService.listAllUsers(pageNum);

		assertEquals(expectedPage, resultPage);
		verify(userRepository, times(1)).findAll(pageable);
	}

	@Test
	public void testDeleteUsers() {
		List<Long> ids = new ArrayList<>();
		doNothing().when(userRepository).deleteAllById(ids);

		userService.deleteUsers(ids);

		verify(userRepository, times(1)).deleteAllById(ids);
	}
}
