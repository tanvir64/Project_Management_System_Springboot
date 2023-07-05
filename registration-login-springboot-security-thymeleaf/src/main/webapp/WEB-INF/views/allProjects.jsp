<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Project List</title>
    <style>
        .project-table {
            width: 100%;
            border-collapse: collapse;
        }

        .project-table th,
        .project-table td {
            padding: 10px;
            text-align: left;
        }

        .project-table th {
            background-color: #f2f2f2;
            color: #333;
            font-weight: bold;
        }

        .project-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .project-table tbody tr:nth-child(odd) {
            background-color: #e6e6e6;
        }

        .project-table a.action-link {
            margin-right: 5px;
            color: #337ab7;
            text-decoration: none;
        }

        .project-table a.action-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<table class="project-table">
    <thead>
    <tr>
        <th>Name</th>
        <th>Intro</th>
<%--        <th>Owner</th>--%>
        <th>Status</th>
        <th>Start Date</th>
        <th>End Date</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${projects}" var="project" varStatus="loop">
        <tr class="${loop.index % 2 == 0 ? 'even' : 'odd'}">
            <td>${project.getProjectName()}</td>
            <td>${project.getProjectIntro()}</td>
            <td>${project.getProjectOwner().getUsername()}</td>
            <td>${project.getProjectStatus()}</td>
            <td>${project.getProjectStartDateTime()}</td>
            <td>${project.getProjectEndDateTime()}</td>
            <td>
                <a href="/api/v1/projects/view/${project.getId()}" class="action-link">View</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
