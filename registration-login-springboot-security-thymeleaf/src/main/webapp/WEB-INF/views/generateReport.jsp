<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

    <style>
        .datepicker-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .datepicker-input {
            margin: 10px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .report-format-button {
            background: #4CAF50;
            color: white;
            margin: 10px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }
    </style>
</head>
<body>
<form action="/api/v1/generateReport/${format}" method="post">
    <div class="datepicker-container">
        <input type="date" id="startDateTime" class="datepicker-input" name="startDateTime" required>
        <input type="date" id="endDateTime" class="datepicker-input" name="endDateTime" required>
        <h2>Select the Report Format to be generated</h2>
        <select name="format" id="format" class="report-format-button">
            <option value="pdf">PDF</option>
            <option value="html">HTML</option>
        </select>
        <button type="submit" class="report-format-button">Generate</button>
    </div>
</form>
</body>
</html>

