<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Edit Project</title>
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

        .edit-project-form {
            width: 400px;
            background-color: #fff;
            padding: 40px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .edit-project-form h2 {
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

        #assignMembers option[selected] {
            background-color: blue;
            color: white;
        }
    </style>
</head>
<body>
<div class="edit-project-form">
    <h2>Edit Project</h2>
    <!-- Replace the form fields with appropriate values based on the project data -->
    <form action="/api/v1/projects/edit/${project.id}" method="POST">
        <div class="form-group">
            <label for="projectName">Name:</label>
            <input type="text" id="projectName" name="projectName" value="${project.getProjectName()}" required>
        </div>
        <div class="form-group">
            <label for="projectIntro">Introduction:</label>
            <input type="text" id="projectIntro" name="projectIntro" value="${project.getProjectIntro()}" required>
        </div>
        <div class="form-group">
            <label for="projectStartDateTime">Start Date:</label>
            <input type="date" id="projectStartDateTime" name="projectStartDateTime"
                   value="${project.getProjectStartDateTime()}"
            <c:if test="${project.getProjectStatus() == 'STARTED' || project.getProjectStatus() == 'ENDED'}">
                   readonly
            </c:if>
            >
        </div>

        <div class="form-group">
            <label for="projectEndDateTime">End Date:</label>
            <input type="date" id="projectEndDateTime" name="projectEndDateTime"
                   value="${project.getProjectEndDateTime()}"
            <c:if test="${project.getProjectStatus() == 'ENDED'}">
                   readonly
            </c:if>
            >
        </div>

        <div class="form-group">
            <label for="projectStatus">Status:</label>
            <input type="text" id="projectStatus" name="projectStatus" value="${project.getProjectStatus()}" readonly>
        </div>

        <div class="form-group">
            <label for="assignMembers">Add Members:</label>
            <select id="assignMembers" name="assignMembers" multiple>
                <c:forEach items="${membersList}" var="member">
                    <c:if test="${!selectedMemberIds.contains(member.getId())}">
                        <option value="${member.getId()}">${member.getUsername()}</option>
                    </c:if>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="removeMembers">Remove Members:</label>
            <select id="removeMembers" name="removeMembers" multiple>
                <c:forEach items="${membersList}" var="member">
                    <c:if test="${selectedMemberIds.contains(member.getId())}">
                        <option value="${member.getId()}">${member.getUsername()}</option>
                    </c:if>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <input type="submit" value="Save Changes">
        </div>

    </form>
    <span><a href="/api/v1/projects/view/${project.id}" class="styled-button">Back</a></span>
</div>
</body>
</html>
