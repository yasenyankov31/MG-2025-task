package com.game.classes.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.game.classes.interfaces.jpa.UserRepository;
import com.game.classes.models.UserData;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;

	public void createUser(UserData user) {
		// TODO : Add create jpa logic
	}

	public void updateUser(UserData user) {
		// TODO : Add update jpa logic
	}

	public Page<UserData> listAllUsers(Integer pageNum) {
		PageRequest pageable = PageRequest.of(pageNum, 5, Sort.by(Sort.Direction.DESC, "id"));
		return userRepository.findAll(pageable);
	}

	public void deleteUsers(List<Long> ids) {
		userRepository.deleteAllById(ids);
	}

	public boolean checkIfUserExist(String username) {
		return userRepository.findAllByUsername(username).isEmpty();
	}

	public void deleteUser(Long id) {
		userRepository.deleteById(id);

	}

	public boolean checkIfUserExist(Long id) {
		return userRepository.findById(id).isPresent();
	}
}
