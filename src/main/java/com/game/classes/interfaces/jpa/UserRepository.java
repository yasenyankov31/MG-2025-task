package com.game.classes.interfaces.jpa;

import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.game.classes.models.UserData;

@Repository
public interface UserRepository extends JpaRepository<UserData, Long> {

  Page<UserData> findAll(Pageable pageable);

  List<UserData> findAllByUsername(String username);

  Optional<UserData> findByUsername(String username);

}
