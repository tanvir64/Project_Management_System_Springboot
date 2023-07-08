<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Create Project</title>
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

        .create-project-form {
            width: 500px;
            background-color: #fff;
            padding: 40px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .create-project-form h2 {
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
            padding: 12px;
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
            width: 100%;
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
            display: block;
            margin: 0 auto;
        }

        .form-group input[type="submit"]:hover {
            background-color: #23527c;
        }

        .form-group textarea {
            width: 100%;
        }


    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Handle select change event
            $("#assignMembers").on("change", function() {
                var selectedCount = $(this).find("option:selected").length;
                var maxSelectionLimit = 5; // Maximum number of allowed selections

                if (selectedCount > maxSelectionLimit) {
                    // If the number of selected options exceeds the limit, deselect the last selected option
                    $(this).find("option:selected").last().prop("selected", false);
                }
            });
        });
    </script>
</head>
<body>
<div class="create-project-form">
    <h2>Create Project</h2>
    <!-- Update the form field names to match the attribute names in the Project class -->
    <form action="/api/v1/projectList" method="POST">
        <div class="form-group">
            <label for="projectName">Name:</label>
            <input type="text" id="projectName" name="projectName" required>
        </div>
        <div class="form-group">
            <label for="projectIntro">Introduction:</label>
            <textarea id="projectIntro" name="projectIntro" rows="5" required></textarea>
        </div>
        <div class="form-group">
            <label for="projectStartDateTime">Start Date:</label>
            <input type="date" id="projectStartDateTime" name="projectStartDateTime">
        </div>
        <div class="form-group">
            <label for="projectEndDateTime">End Date:</label>
            <input type="date" id="projectEndDateTime" name="projectEndDateTime">
        </div>
        <div class="form-group">
            <label for="assignMembers">Assign Members:</label>
            <select id="assignMembers" name="assignMembers" multiple>
                <c:forEach items="${membersList}" var="member">
                    <option value="${member.getId()}">${member.getUsername()}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <input type="submit" value="Create Project">
        </div>
    </form>
</div>
</body>
</html>
