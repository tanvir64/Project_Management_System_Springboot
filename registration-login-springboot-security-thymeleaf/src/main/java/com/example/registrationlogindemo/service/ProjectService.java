package com.example.registrationlogindemo.service;

import com.example.registrationlogindemo.entity.Project;
import com.example.registrationlogindemo.exception.RecordNotFoundException;

import java.time.LocalDate;
import java.util.List;

public interface ProjectService {
    List<Project> getProjectsForCurrentMonth();

    Project getProjectByUserId(Long id);

    void updateProject(Long id,Project project, List<Long> selectedMemberIds) throws RecordNotFoundException;

    boolean addMemberToProject(Project project,List<Long> selectedMemberIds);

    void deleteProject(Long id);

    List<Project> getAllProjects();

    Project getProjectById(Long id);

    void createProject(Project project);

    List<Project> getFilteredProjects(LocalDate projectStartDateTime, LocalDate projectEndDateTime);

    List<Long> getProjectMemberIds(Long id);
}
