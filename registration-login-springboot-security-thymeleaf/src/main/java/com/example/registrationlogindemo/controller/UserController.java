package com.example.registrationlogindemo.controller;

import com.example.registrationlogindemo.dto.UserDto;
import com.example.registrationlogindemo.entity.User;
import com.example.registrationlogindemo.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/")
public class UserController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }


    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }

    // handler method to handle user registration request
    @GetMapping("/register")
    public String showRegistrationForm(Model model){
        UserDto user = new UserDto();
        model.addAttribute("user", user);
        return "register";
    }

    // handler method to handle register user form submit request
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") UserDto user,
                               BindingResult result,
                               Model model){
        if (result.hasErrors()) {
            System.out.println("result = " + result);
            model.addAttribute("error", "Invalid input");
            return "register";
        }
        if (!userService.isValidEmail(user.getEmail())) {
            model.addAttribute("error", "Invalid email");
            result.rejectValue("email", "error.user", "Invalid email");
            return "register";
        }

        if (userService.userExists(user.getEmail())) {
            model.addAttribute("error", "User already exists");
            result.rejectValue("email", "error.user", "User already exists");
            return "register";
        }

        if (!userService.isValidPassword(user.getPassword())) {
            model.addAttribute("error", "Password must be at least 8 characters long");
            result.rejectValue("password", "error.user", "Invalid password");
            return "register";
        }
        model.addAttribute("success", "User created successfully");
        userService.registerUser(user);
        return "redirect:/login";
    }

    @PostMapping("/")
    public String home(Model model, @RequestParam("username") String username, @RequestParam("password") String password){
        System.out.println("username = " + username + "password" + password);
        User user = userService.findByEmail(username);
        System.out.println("user = " + username + "password" + password);

        if(userService.login(username, password)) {
            Authentication authenticationToken = new UsernamePasswordAuthenticationToken(username, password);

            // Set the authentication token in the security context
            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            System.out.println("user = " + username + "password" + password);
            model.addAttribute("success", "Logged in successfully!!");
            return "redirect:/api/v1/projectsList";
        }
        else {
            model.addAttribute("error", "Invalid email or password");
            return "redirect:/login";
        }
    }

    @GetMapping("/users")
    public String listRegisteredUsers(Model model){
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "users";
    }
}
