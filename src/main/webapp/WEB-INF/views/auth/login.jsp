<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EduTrack - Login</title>
            <!-- Bootstrap 5 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- FontAwesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            <style>
                body {
                    background-color: #f8f9fa;
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .login-card {
                    width: 100%;
                    max-width: 400px;
                    padding: 2rem;
                    border-radius: 10px;
                    background: white;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                }

                .login-header {
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .login-header i {
                    color: #0d6efd;
                }
            </style>
        </head>

        <body>

            <div class="login-card">
                <div class="login-header">
                    <i class="fas fa-graduation-cap fa-3x mb-3"></i>
                    <h3>Welcome Back</h3>
                    <p class="text-muted">Sign in to EduTrack</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username"
                                placeholder="Enter username" required autofocus>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password"
                                placeholder="Enter password" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="captcha" class="form-label">Captcha</label>
                        <div class="d-flex align-items-center mb-2">
                            <img src="${pageContext.request.contextPath}/captcha" alt="Captcha" class="border rounded"
                                id="captcha-img" />
                            <button type="button" class="btn btn-sm btn-outline-secondary ms-2"
                                onclick="document.getElementById('captcha-img').src='${pageContext.request.contextPath}/captcha?'+new Date().getTime()">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                        </div>
                        <input type="text" class="form-control" id="captcha" name="captcha" placeholder="Enter captcha"
                            required>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Sign In</button>
                    </div>

                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/register" class="text-decoration-none">Register as
                            Student</a>
                    </div>
                </form>
            </div>

            <!-- Bootstrap 5 JS Bundle -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>