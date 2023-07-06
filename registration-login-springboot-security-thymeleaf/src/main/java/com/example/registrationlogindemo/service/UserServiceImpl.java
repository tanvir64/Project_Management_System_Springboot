package com.example.registrationlogindemo.service;

import com.example.registrationlogindemo.dto.UserDto;
import com.example.registrationlogindemo.entity.User;
import com.example.registrationlogindemo.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository userRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void registerUser(UserDto userDto) {
        User user = new User();
//        user.setUsername(userDto.getFirstName() + " " + userDto.getLastName());
        user.setUsername(userDto.getUserName());
        user.setEmail(userDto.getEmail());
        user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        userRepository.save(user);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public List<UserDto> findAllUsers() {
        List<User> users = userRepository.findAll();
        return users.stream().map(this::convertEntityToDto)
                .collect(Collectors.toList());
    }

    private UserDto convertEntityToDto(User user){
        UserDto userDto = new UserDto();
        String[] name = user.getUsername().split(" ");
        userDto.setFirstName(name[0]);
        userDto.setLastName(name[1]);
        userDto.setEmail(user.getEmail());
        return userDto;
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public User getUser(String userName) {
        User user = userRepository.findByUsername(userName);

        if (user != null) {
            return user;
        } else {
            return new User();
        }
    }

    @Override
    public Optional<User> getUserById(Long id){
        return userRepository.findById(id);
    }

    @Override
    public boolean login(String name, String password) {
        System.out.println(name + " " + password);
        User user = userRepository.findByUsername(name);
        if(user != null){
            System.out.println(user.getPassword() + " " + passwordEncoder.encode(password));
            return passwordEncoder.matches(password, user.getPassword());
        }
        return false;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = userRepository.findAll();

        if (users.size() > 0) {
            return users;
        } else {
            return new ArrayList<User>();
        }
    }

    @Override
    public boolean isValidEmail(String email) {
        return email.contains("@");
    }

    @Override
    public boolean userExists(String email) {
        return userRepository.findByEmail(email) != null;
    }

    @Override
    public boolean isValidPassword(String password) {
        return password.length() >= 8 && password.matches(".*[a-zA-Z]+.*") && password.matches(".*[0-9]+.*");
    }
}
