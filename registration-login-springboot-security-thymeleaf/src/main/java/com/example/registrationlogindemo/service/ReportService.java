package com.example.registrationlogindemo.service;

import com.example.registrationlogindemo.dto.ProjectDTO;
import com.example.registrationlogindemo.entity.Project;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.io.FileNotFoundException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReportService {
    @Autowired
    private ProjectService projectService;

    public Boolean exportReport(String reportFormat, LocalDate projectStartDateTime, LocalDate projectEndDateTime) throws FileNotFoundException, JRException {
        List<Project> projects = projectService.getFilteredProjects(projectStartDateTime,projectEndDateTime);
        Boolean created = false;
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
        // load file and compile it
        String filePath = "D:\\Spring boot\\Report";
        File file = ResourceUtils.getFile("classpath:AllProjects.jrxml");
        JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(projectDTOs);
        Map<String,Object> parameters = new HashMap<>();
        parameters.put("createdBy", "Md. Tanvir Raihan");
        System.out.println("create korte aschi");
        System.out.println("reportFormat = " + reportFormat);
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,dataSource);
        if(reportFormat.equalsIgnoreCase("html")){
            created = true;
            JasperExportManager.exportReportToHtmlFile(jasperPrint,filePath+"\\Projects.html");
        }
        if(reportFormat.equalsIgnoreCase("pdf")){
            created = true;
            JasperExportManager.exportReportToPdfFile(jasperPrint,filePath+"\\Projects.pdf");
            System.out.println("create korsi");
        }
        return created;
    }
}
