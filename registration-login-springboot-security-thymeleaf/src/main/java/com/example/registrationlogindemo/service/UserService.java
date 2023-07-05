package com.example.registrationlogindemo.service;

import com.example.registrationlogindemo.dto.UserDto;
import com.example.registrationlogindemo.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    void registerUser(UserDto userDto);

    List<UserDto> findAllUsers();

    List<User> getAllUsers();

    boolean login(String email, String password);

    User getUser(String userName);

    Optional<User> getUserById(Long id);

    boolean isValidEmail(String email);

    boolean userExists(String email);

    boolean isValidPassword(String password);

    User findByEmail(String email);

    User findByName(String username);
}
