<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Project Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%= request.getContextPath() %>">Project Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>
<br/>
<br/>
<br/>
<div class="container">
    <div class="row col-md-8 offset-md-2">
        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger">Invalid Email and Password.</div>
        <% } %>
        <div class="card">
                <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-info">You've successfully registered to our app!</div>
                <% } %>
            <div class="card-header">
                <h2 class="text-center">Registration</h2>
            </div>
            <div class="card-body">
                <form method="post" role="form" action="/api/v1/register">
<%--                      modelAttribute="user">--%>

                    <div class="form-group mb-3">
                        <label for="firstName" class="form-label">First Name</label>
                        <input class="form-control" id="firstName" name="firstName" placeholder="Enter first name"
                               type="text" required/>
                    </div>

                    <div class="form-group mb-3">
                        <label for="lastName" class="form-label">Last Name</label>
                        <input class="form-control" id="lastName" name="lastName" placeholder="Enter last name"
                               type="text" required/>
                    </div>
                    <div class="form-group mb-3">
                        <label for="userName" class="form-label">Username</label>
                        <input class="form-control" id="userName" name="userName" placeholder="Enter a username"
                               type="text" required/>
                    </div>
                    <div class="form-group mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input class="form-control" id="email" name="email" placeholder="Enter email address"
                               type="email" required/>
                    </div>
                    <div class="form-group mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input class="form-control" id="password" name="password" placeholder="Enter password"
                               type="password" required/>
                    </div>

                    <div class="form-group mb-3">
                        <button class="btn btn-primary" type="submit">Register</button>
                        <span> Already have an account?
                                <a href="/api/v1/login"> Log in to your account</a>
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>