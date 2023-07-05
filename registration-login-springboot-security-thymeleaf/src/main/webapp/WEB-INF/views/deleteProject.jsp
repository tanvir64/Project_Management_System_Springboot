<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Delete Project</title>
    <link rel="stylesheet" href="path/to/jquery-ui.css">
    <script src="path/to/jquery.js"></script>
    <script src="path/to/jquery-ui.js"></script>
    <style>
        /* CSS for sophisticated and beautiful UI */
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .delete-project-form {
            width: 400px;
            background-color: #fff;
            padding: 40px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .delete-project-form h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .form-group {
            margin-bottom: 30px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #666;
        }

        .form-group input[type="text"],
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
            color: #666;
        }

        .form-group select {
            height: 100px;
        }

        .form-group input[type="date"] {
            height: 40px;
        }

        .form-group input[type="submit"] {
            background-color: #337ab7;
            color: #fff;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .form-group input[type="submit"]:hover {
            background-color: #23527c;
        }

        .delete-button {
            background-color: #ff4d4d;
        }

        .delete-button:hover {
            background-color: #ff1a1a;
        }
    </style>
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete this project?");
        }
    </script>
</head>
<body>
<div class="delete-project-form">
    <h2>Delete Project</h2>
    <!-- Replace the form fields with appropriate values based on the project data -->
    <form action="/api/v1/projects/delete/${project.id}" method="POST">
        <div class="form-group">
            <label for="projectName">Name:</label>
            <input type="text" id="projectName" name="projectName" value="${project.getProjectName()}" readonly>
        </div>
        <div class="form-group">
            <label for="projectIntro">Introduction:</label>
            <input type="text" id="projectIntro" name="projectIntro" value="${project.getProjectIntro()}" readonly>
        </div>
        <div class="form-group">
            <label for="projectStartDateTime">Start Date:</label>
            <input type="text" id="projectStartDateTime" name="projectStartDateTime" value="${project.getProjectStartDateTime()}" readonly>
        </div>
        <div class="form-group">
            <label for="projectEndDateTime">End Date:</label>
            <input type="text" id="projectEndDateTime" name="projectEndDateTime" value="${project.getProjectEndDateTime()}" readonly>
        </div>
        <div class="form-group">
            <label>Assigned Members:</label>
                <c:forEach items="${membersList}" var="member">
                    <option value="${member.getId()}">${member.getUsername()}</option>
                </c:forEach>
        </div>
        <div class="form-group">
            <input type="submit" value="Delete Project" class="delete-button" onclick="return confirmDelete()">
        </div>
    </form>
</div>
</body>
</html>
