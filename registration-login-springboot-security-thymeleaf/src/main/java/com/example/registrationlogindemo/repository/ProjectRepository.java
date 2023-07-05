package com.example.registrationlogindemo.repository;

import com.example.registrationlogindemo.entity.Project;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface ProjectRepository extends JpaRepository<Project, Long> {
    Project findByProjectName(String projectName);
    List<Project> findAllByProjectStartDateTimeBetween(LocalDate start_date, LocalDate end_date);
}
