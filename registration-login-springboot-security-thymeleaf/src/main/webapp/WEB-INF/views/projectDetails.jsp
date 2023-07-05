<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Project Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        td {
            color: #666;
        }

        .table-header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px;
        }

        .table-row:nth-child(even) {
            background-color: #f9f9f9;
        }
        .center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin-top: 20px; /* Added margin to separate the button from the table */
        }

        .styled-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            align-items: center;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }

        .edit-project-button {
            display: inline-block;
            background-color: blue;
            color: #fff;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
        }

        .edit-project-button:hover {
            background-color: darkblue;
        }

        .delete-project-button {
            display: inline-block;
            background-color: red;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
        }

        .delete-project-button:hover {
            background-color: darkred;
        }

        .styled-button{
            display: inline-block;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
        }

        .styled-button:hover{
            background-color: #46a049;
        }

    </style>
</head>
<body>
<h1 align="center">Project Details</h1>
<table>
    <tr class="table-header">
        <th colspan="2" >Project Details</th>
    </tr>
    <tr class="table-row">
        <th>Name:</th>
        <td>${project.getProjectName()}</td>
    </tr>
    <tr class="table-row">
        <th>Introduction:</th>
        <td>${project.getProjectIntro()}</td>
    </tr>
    <tr class="table-row">
        <th>Owner:</th>
        <td>${project.getProjectOwner().getUsername()}</td>
    </tr>
    <tr class="table-row">
        <th>Status:</th>
        <td>${project.getProjectStatus()}</td>
    </tr>
    <tr class="table-row">
        <th>Start Date:</th>
        <td>${project.getProjectStartDateTime()}</td>
    </tr>
    <tr class="table-row">
        <th>End Date:</th>
        <td>${project.getProjectEndDateTime()}</td>
    </tr>
    <tr>
        <th>Members:</th>
        <td>
            <c:forEach items="${userList}" var="user">
                ${user.getUsername()}<br>
            </c:forEach>
        </td>
    </tr>


</table>
<%--<c:if test="${project.getProjectOwner().getUsername() eq currentUser.getUsername()}">--%>
<%--    <a href="/api/v1/projects/edit/${project.getId()}" class="edit-project-button">Edit</a>--%>
<%--    <a href="/api/v1/projects/delete/${project.getId()}" class="delete-project-button">Delete</a>--%>
<%--</c:if>--%>
<a href="/api/v1/projects/edit/${project.getId()}" class="edit-project-button">Edit</a>
<a href="/api/v1/projects/delete/${project.getId()}" class="delete-project-button">Delete</a>
<a href="/api/v1/projectsList" class="styled-button">Back</a>

</body>
</html>
