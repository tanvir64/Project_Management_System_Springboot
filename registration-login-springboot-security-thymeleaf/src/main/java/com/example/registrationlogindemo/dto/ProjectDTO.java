package com.example.registrationlogindemo.dto;

import lombok.*;

import java.time.LocalDate;

@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ProjectDTO {
    private Long id;
    private String projectName;
    private String projectIntro;
    private int projectStatus;
    private LocalDate projectStartDateTime;
    private LocalDate projectEndDateTime;
    private String projectOwnerName;
}
