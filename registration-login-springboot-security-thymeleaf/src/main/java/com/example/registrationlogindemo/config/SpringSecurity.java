package com.example.registrationlogindemo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SpringSecurity {

    @Autowired
    private UserDetailsService userDetailsService;

    @Bean
    public static PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .authorizeHttpRequests((authorize) ->
                        authorize
                                .antMatchers("/api/v1/register/**").permitAll()
                                .antMatchers("/api/v1/users**").permitAll()
                                .antMatchers("/api/v1/projects").permitAll()

//                                .antMatchers("/api/v1/projectsList").authenticated()  // Limit access to "/api/v1/projectsList" to authenticated users
//                                .antMatchers("/api/v1/projects/view/{id}").authenticated()  // Limit access to "/api/v1/projects/view/{id}" to authenticated users
//                                .antMatchers("/api/v1/projects/edit/{id}").authenticated()
//                                .antMatchers("/api/v1/projects/delete/{id}").authenticated()
//                                .antMatchers("/api/v1/report/{format}").authenticated()
//                                .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/api/v1/login")
                        .loginProcessingUrl("/api/v1/login")
                        .permitAll()
//                        .successHandler((request, response, authentication) -> {
//                            // Customize the redirect URLs based on your logic
//                            if (authentication.isAuthenticated()) {
//                                response.sendRedirect("/api/v1/admin");
//                            } else if (authentication.isAuthenticated()) {
//                                response.sendRedirect("/api/v1/user");
//                            } else {
//                                response.sendRedirect("/api/v1/default");
//                            }
//                        })
                        .failureUrl("/api/v1/login?error=true")
                )
                .logout(
                        logout -> logout
                                .logoutRequestMatcher(new AntPathRequestMatcher("/api/v1/logout"))
                                .permitAll()
                );
        return http.build();
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());
    }
}
