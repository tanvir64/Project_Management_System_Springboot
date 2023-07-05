package com.example.registrationlogindemo.service;

import com.example.registrationlogindemo.entity.Project;
import com.example.registrationlogindemo.entity.User;
import com.example.registrationlogindemo.exception.RecordNotFoundException;
import com.example.registrationlogindemo.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class ProjectServiceImpl implements ProjectService {
    @Autowired
    ProjectRepository projectRepository;

    @Autowired
    UserService userService;

    @Override
    public List<Project> getProjectsForCurrentMonth() {
        LocalDate current_date = LocalDate.now();
        LocalDate start_date = LocalDate.of(current_date.getYear(), current_date.getMonth(), 1);
        LocalDate end_date = LocalDate.of(current_date.getYear(), current_date.getMonth(), current_date.lengthOfMonth());
        return projectRepository.findAllByProjectStartDateTimeBetween(start_date, end_date);
    }

    @Override
    public Project getProjectByUserId(Long id) {
        return projectRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Project not found"));
    }

    @Override
    public boolean addMemberToProject(Project project, List<Long> selectedMemberIds) {
        System.out.println("id: "+project.getId());
        if(selectedMemberIds == null){
            return false;
        }
        for (Long userId : selectedMemberIds) {
            User member = null;
            member = userService.getUserById(userId).get();
            if(project.getUsers().contains(member)){
                continue;
            }
            project.getUsers().add(member);
            member.getProjects().add(project);
        }
        System.out.println("member added to project");
        return true;
    }

    @Override
    public void updateProject(Long id, Project project, List<Long> selectedMemberIds) throws RecordNotFoundException {
        Project projectToUpdate = projectRepository.findById(id)
                .orElseThrow(() -> new RecordNotFoundException("Project not found"));
        projectToUpdate.setProjectName(project.getProjectName());
        projectToUpdate.setProjectIntro(project.getProjectIntro());
        projectToUpdate.setProjectStartDateTime(project.getProjectStartDateTime());
        projectToUpdate.setProjectEndDateTime(project.getProjectEndDateTime());
        projectToUpdate.setProjectStatus(project.getProjectStatus());
        projectToUpdate.setProjectOwner(project.getProjectOwner());
        addMemberToProject(projectToUpdate, selectedMemberIds);
        projectRepository.save(project);
    }

    @Override
    public List<Long> getProjectMemberIds(Long id){
        List<Long> selectedMemberIds = new ArrayList<>();
        Project project = getProjectById(id);
        List<User> projectMembers = project.getUsers();
        for(User member : projectMembers){
            Long memberId = member.getId();
            selectedMemberIds.add(memberId);
        }
        return selectedMemberIds;
    }

    @Override
    public void deleteProject(Long id) {
        Project projectToDelete = projectRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Project not found"));
        List<User> projectUsers = projectToDelete.getUsers();
        projectUsers.forEach(user -> user.getProjects().remove(projectToDelete));
        projectRepository.delete(projectToDelete);
    }

    @Override
    public List<Project> getAllProjects() {
        return projectRepository.findAll();
    }

    @Override
    public Project getProjectById(Long id) {
        return projectRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Project not found"));
    }

    @Override
    public void createProject(Project project) {
        projectRepository.save(project);
    }

    @Override
    public List<Project> getFilteredProjects(LocalDate projectStartDateTime, LocalDate projectEndDateTime) {
        return projectRepository.findAllByProjectStartDateTimeBetween(projectStartDateTime, projectEndDateTime);
    }
}
