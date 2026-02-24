<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EduTrack - Email Verification</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                    max-width: 420px;
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
                    <i class="fas fa-envelope-open-text fa-3x mb-3"></i>
                    <h3>Email Verification</h3>
                    <p class="text-muted">We've sent a 6-digit OTP to your email. Enter it below to complete login.</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/2fa" method="post">
                    <div class="mb-3">
                        <label for="code" class="form-label">OTP Code</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-key"></i></span>
                            <input type="text" class="form-control form-control-lg text-center" id="code" name="code"
                                placeholder="______" required autofocus maxlength="6"
                                style="letter-spacing: 8px; font-weight: bold;">
                        </div>
                        <small class="text-muted">Code expires in 5 minutes.</small>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Verify & Sign In</button>
                    </div>
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Back to
                            Login</a>
                    </div>
                </form>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>