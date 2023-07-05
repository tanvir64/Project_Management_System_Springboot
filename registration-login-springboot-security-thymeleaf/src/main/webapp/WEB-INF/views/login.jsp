<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Project Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" th:fragment="header">
    <div class="container-fluid">
        <a class="navbar-brand" th:href="@{/}">Project Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>
<br />
<br />
<br />
<div class="container">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">Invalid Email and Password.</div>
            </c:if>
            <c:if test="${not empty param.logout}">
                <div class="alert alert-success">You have been logged out.</div>
            </c:if>
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center">Login Form</h3>
                </div>
                <div class="card-body">
                    <form
                            method="post"
                            action="/"
                            class="form-horizontal"
                            role="form"
                    >
                        <div class="mb-3">
                            <label for="username" class="control-label">Username *</label>
                            <input type="text"
                                   id="username"
                                   name="username"
                                   class="form-control"
                                   placeholder="Name"
                                   required
                            />
                        </div>

                        <div class="mb-3">
                            <label for="password" class="control-label">Password *</label>
                            <input type="password"
                                   id="password"
                                   name="password"
                                   class="form-control"
                                   placeholder="Password"
                                   required
                            />
                        </div>

                        <div class="mb-3">
                            <button type="submit" class="btn btn-primary">Login</button>
                            <span> Not registered?
                                <a href="/api/v1/register"> Register/SignUp Here</a>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
