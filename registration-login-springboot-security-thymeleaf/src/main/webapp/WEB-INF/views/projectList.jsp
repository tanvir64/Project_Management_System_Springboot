<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Project List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <style>
        /* CSS for responsive and beautiful UI */
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .error-message {
            color: #d8000c;
            background-color: #ffbaba;
            border: 1px solid #d8000c;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            text-align: center;
        }

        .success-message {
            color: #4f8a10;
            background-color: #dff2bf;
            border: 1px solid #4f8a10;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            text-align: center;
        }

        .container {
            max-width: 400px; /* Set the desired maximum width */
            margin: 0 auto; /* Center the container horizontally */
        }

        .project-table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .project-table th,
        .project-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
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
            background-color: #fff;
            border: 1px solid #337ab7;
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }

        .project-table a.action-link:hover {
            background-color: #337ab7;
            color: #fff;
            text-decoration: none;
        }

        .create-project-container {
            margin-right: auto;
            margin-top: 20px;
            margin-bottom: 20px;
            text-align: center;
        }

        .create-project-button {
            display: block;
            background-color: #337ab7;
            color: #fff;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
        }

        .create-project-button:hover {
            background-color: #23527c;
        }

        .datepicker-container {
            margin-left: 150px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 20px;
        }

        .datepicker-input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
        }

        .filter-button {
            background-color: cornflowerblue;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .filter-button:hover {
            background-color: blue;
        }

        .view-project-button {
            display: inline-block;
            background-color: limegreen;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
        }

        .view-project-button:hover {
            background-color: darkgreen;
        }

        .filter-button {
            background-color: cornflowerblue;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .filter-button:hover {
            background-color: blue;
        }



    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/smoothness/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <script>
        $(function () {
            $("#startDate").datepicker({
                dateFormat: 'yy-mm-dd',
                showOtherMonths: true,
                selectOtherMonths: true,
                beforeShow: function (input, inst) {
                    setTimeout(function () {
                        inst.dpDiv.addClass('custom-datepicker');
                    }, 0);
                }
            });

            $("#endDate").datepicker({
                dateFormat: 'yy-mm-dd',
                showOtherMonths: true,
                selectOtherMonths: true,
                beforeShow: function (input, inst) {
                    setTimeout(function () {
                        inst.dpDiv.addClass('custom-datepicker');
                    }, 0);
                }
            });
        });
    </script>
    <script>
        // Timeout duration in milliseconds
        const timeoutDuration = 3000;

        // Hide error message after timeout
        const errorMessage = document.getElementById('error-message');
        if (errorMessage) {
            setTimeout(function() {
                errorMessage.style.display = 'none';
            }, timeoutDuration);
        }

        // Hide success message after timeout
        const successMessage = document.getElementById('success-message');
        if (successMessage) {
            setTimeout(function() {
                successMessage.style.display = 'none';
            }, timeoutDuration);
        }
    </script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Project Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/api/v1/register">Register</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/api/v1/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <c:if test="${not empty error}">
        <div id="error-message" class="error-message">${error}</div>
    </c:if>

    <c:if test="${not empty success}">
        <div id="success-message" class="success-message">${success}</div>
    </c:if>
</div>
<div class="create-project-container">
    <a href="/api/v1/create-project" class="create-project-button">Create Project</a>
</div>
<form action="/api/v1/projectsList/filter" method="GET">
    <div class="datepicker-container">
        <input type="date" id="projectStartDateTime" class="datepicker-input" name="projectStartDateTime" required>
        <input type="date" id="projectEndDateTime" class="datepicker-input" name="projectEndDateTime" required>
        <button type="submit" id="filterProjectsButton" class="filter-button" name="filterButton">Filter</button>
    </div>
</form>

<c:if test="${empty projects}">
    <div class="no-projects-found">
        <h2>No Projects Found</h2>
    </div>
</c:if>
<c:if test="${not empty projects}">
    <table class="project-table">
        <thead>
        <tr>
            <th>Name</th>
            <th>Intro</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${projects}" var="project" varStatus="loop">
            <tr class="${loop.index % 2 == 0 ? 'even' : 'odd'}">
                <td>${project.getProjectName()}</td>
                <td>${project.getProjectIntro()}</td>
                <td>
                    <a href="/api/v1/projects/view/${project.getId()}" class="view-project-button">View Details</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>
<div>
<form id="reportForm" action="/api/v1/generateReport" method="GET">
    <button type="submit" class="filter-button" name="filterButton">Generate Report</button>
</form>
</div>
<%--<script>--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        var generateReportButton = document.getElementById('generateReportButton');--%>
<%--        var reportFormatButtons = document.getElementById('reportFormatButtons');--%>
<%--        var reportForm = document.getElementById('reportForm');--%>

<%--        generateReportButton.addEventListener('click', function() {--%>
<%--            reportFormatButtons.style.display = 'block';--%>
<%--        });--%>

<%--        reportForm.addEventListener('submit', function(event) {--%>
<%--            var selectedFormat = document.querySelector('button.report-format-button:checked').value;--%>
<%--            var actionPath = "/api/v1/generateReport/" + selectedFormat;--%>
<%--            console.log(actionPath);--%>
<%--            reportForm.setAttribute("action", actionPath);--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>

</body>
</html>
