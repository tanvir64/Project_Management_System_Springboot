package com.example.registrationlogindemo.controller;

import com.example.registrationlogindemo.dto.ProjectDTO;
import com.example.registrationlogindemo.entity.Project;
import com.example.registrationlogindemo.entity.User;
import com.example.registrationlogindemo.service.ProjectService;
import com.example.registrationlogindemo.service.ReportService;
import com.example.registrationlogindemo.service.UserService;
import net.sf.jasperreports.engine.JRException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.FileNotFoundException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/")
public class ProjectController {
    @Autowired
    private ProjectService projectService;

    @Autowired
    private UserService userService;

    @Autowired
    private ReportService reportService;

//    get all projects and show them in json format

    @GetMapping(value="/api/v1/projects", produces = "application/json")
    @ResponseBody
    public List<ProjectDTO> getProjectList() {
        List<Project> projects = projectService.getAllProjects();
        List<ProjectDTO> projectDTOs = new ArrayList<>();
        for (Project project : projects) {
            ProjectDTO projectDTO = new ProjectDTO();
            projectDTO.setId(project.getId());
            projectDTO.setProjectName(project.getProjectName());
            projectDTO.setProjectIntro(project.getProjectIntro());
            projectDTO.setProjectStatus(project.getProjectStatus());
            projectDTO.setProjectStartDateTime(project.getProjectStartDateTime());
            projectDTO.setProjectEndDateTime(project.getProjectEndDateTime());
            projectDTO.setProjectOwnerName(project.getProjectOwner().getUsername());
            projectDTOs.add(projectDTO);
        }
        return projectDTOs;
    }


    //    get all projects for the current month
    @GetMapping("/api/v1/projectsList")
    public String showProjectList(Model model) {
        List<Project> projects = projectService.getProjectsForCurrentMonth();
//        List<Project> projects = projectService.getAllProjects();
        model.addAttribute("projects", projects);
        return "projectList";
    }

    //   show the filtered projects
    @GetMapping("/api/v1/projectsList/filter")
    public String showFilteredProjectsList(Model model,
                                           @RequestParam("projectStartDateTime") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate projectStartDateTime,
                                           @RequestParam("projectEndDateTime") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate projectEndDateTime) {
        List<Project> projects = projectService.getFilteredProjects(projectStartDateTime, projectEndDateTime);
        model.addAttribute("projects", projects);
        return "projectList";
    }

    //    view a specific project
    @GetMapping("/api/v1/projects/view/{id}")
    public String showProjectDetails(@PathVariable("id") Long id, Model model) {
        Project project = projectService.getProjectById(id);
        model.addAttribute("project", project);
        model.addAttribute("userList", project.getUsers());
        return "projectDetails";
    }

    //    create a new project
    @GetMapping("/api/v1/create-project")
    public String showCreateProjectForm(Model model,HttpSession session) {
        model.addAttribute("project", new Project());
        model.addAttribute("membersList", userService.getAllUsers());
//        System.out.println(session.getAttribute("user"));
        return "createProject";
    }

    //    save the new project and show the updated project list
    @PostMapping("/api/v1/projectList")
    public String createProject(@ModelAttribute("project") @Valid Project project, Model model, @RequestParam("assignMembers") List<Long> selectedMemberIds, HttpSession session) {
        System.out.println("project: " + project.getProjectName()+" "+ project.getProjectIntro()+" "+project.getProjectStartDateTime()+" "+project.getProjectEndDateTime());
        if(project.getProjectStartDateTime().isAfter(project.getProjectEndDateTime())){
            model.addAttribute("error", "Start date should be before end date");
            return "createProject";
        }
        LocalDate current_date = LocalDate.now();
        if(project.getProjectStartDateTime().isAfter(current_date)){
            project.setProjectStatus(0);
        }
        else if(project.getProjectEndDateTime().isBefore(current_date)){
            project.setProjectStatus(3);
        }
        else{
            project.setProjectStatus(1);
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("user: "+authentication.getName());
        User user = userService.findByEmail(authentication.getName());
        project.setProjectOwner(user);
        System.out.println(selectedMemberIds);
        projectService.addMemberToProject(project,selectedMemberIds);
        project.setProjectOwner(user);
        projectService.createProject(project);
        model.addAttribute("projects", projectService.getAllProjects());
        return "redirect:/api/v1/projectsList";
    }

    //    edit a project
    @GetMapping("/api/v1/projects/edit/{id}")
    public String showEditProjectForm(@PathVariable("id") Long id, Model model) {
        System.out.println("id: " + id);
        Project project = projectService.getProjectById(id);
        model.addAttribute("project", project);
        model.addAttribute("membersList", userService.getAllUsers());
        List<Long> selectedMemberIds = projectService.getProjectMemberIds(id);
        model.addAttribute("selectedMemberIds",selectedMemberIds);
        return "editProject";
    }

    @PostMapping("/api/v1/projects/edit/{id}")
    public String editProject(@PathVariable("id") Long id, @ModelAttribute("project") Project project,Model model,@RequestParam(value = "assignMembers",required = false) List<Long> selectedMemberIds) {
        LocalDate current_date = LocalDate.now();
        if(project.getProjectStartDateTime().isAfter(current_date)){
            project.setProjectStatus(0);
        }
        else if(project.getProjectEndDateTime().isBefore(current_date)){
            project.setProjectStatus(3);
        }
        else{
            project.setProjectStatus(1);
        }
        projectService.updateProject(project,selectedMemberIds);
        model.addAttribute("projects", projectService.getAllProjects());
        return "projectList";
    }

    @GetMapping("/api/v1/projects/delete/{id}")
    public String deleteProject(@PathVariable("id") Long id, Model model) {
//        ask for confirmation before deleting a project
        Project project = projectService.getProjectById(id);
        model.addAttribute("project", project);
        model.addAttribute("membersList", project.getUsers());
        return "deleteProject";
    }

    @PostMapping("/api/v1/projects/delete/{id}")
    public String deleteProject(@PathVariable("id") Long id, @ModelAttribute("project") Project project, Model model) {
        projectService.deleteProject(id);
        model.addAttribute("projects", projectService.getAllProjects());
        return "projectList";
    }

//        function for generating jasper report
    @GetMapping("/api/v1/report/{format}")
    @ResponseBody
    public String generateReport(@PathVariable String format) throws JRException, FileNotFoundException {
        return reportService.exportReport(format);
    }
}
