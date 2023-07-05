package com.example.registrationlogindemo.entity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotNull(message = "User name is mandatory")
    @Column(name = "user_name", length = 200, nullable = false, unique = true)
    private String username;

    // password must be at least 8 characters in length and must contain at least one digit, one upper case letter, one lower case letter and one special character
    @NotNull(message = "Password is mandatory")
    @Column(name = "password", length = 300)
    @Size(min = 8, max = 300, message = "Password must be at least 8 characters in length and must contain at least one digit, one upper case letter, one lower case letter and one special character")
    private String password;

    @NotNull(message = "Email address is mandatory")
    @Column(name = "email", length = 200, nullable = false)
    private String email;

    public User(String userName, String password, String email) {
        this.username = userName;
        this.password = password;
        this.email = email;
    }

    @ManyToMany(fetch = FetchType.EAGER,
            cascade = {
                    CascadeType.PERSIST,
                    CascadeType.MERGE
            })
    @JoinTable(name = "project_members",
            joinColumns = {@JoinColumn(name = "user_id")},
            inverseJoinColumns = {@JoinColumn(name = "project_id")})

    private List<Project> projects = new ArrayList<>();

    public void setProjects(List<Project> projects) {
        this.projects = projects;
    }

    public List<Project> getProjects() {
        return projects;
    }
}
