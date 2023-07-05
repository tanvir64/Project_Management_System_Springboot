package com.example.registrationlogindemo.entity;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "project")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Project {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "Project name is required")
    @Column(name = "project_name", nullable = false, length = 50, unique = true)
    private String projectName;

    @Column(name = "project_intro", length = 100)
    private String projectIntro;

    @NotNull(message = "Project status cannot be empty")
    @Column(name = "project_status")
    private int projectStatus;

    @NotNull(message = "Project start date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "project_start_date_time")
    private LocalDate projectStartDateTime;

    @NotNull(message = "Project end date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "project_end_date_time")
    private LocalDate projectEndDateTime;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_owner")
    private User projectOwner;

    @ManyToMany(fetch = FetchType.EAGER,
            cascade = {
                    CascadeType.PERSIST,
                    CascadeType.MERGE
            },mappedBy = "projects")

    private List<User> users = new ArrayList<>();

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public List<User> getUsers() {
        return users;
    }
}
