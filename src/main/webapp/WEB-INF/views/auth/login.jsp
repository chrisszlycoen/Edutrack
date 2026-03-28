<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduTrack - Sign In</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/globals.css" rel="stylesheet">
</head>
<body class="auth-wrapper">

    <div class="auth-container">
        
        <div class="auth-logo">
            <div class="auth-logo-icon">
                <i class="fas fa-layer-group"></i>
            </div>
        </div>

        <div class="saas-card p-4 p-md-5">
            <div class="text-center mb-4">
                <h4 class="fw-bold mb-1">Sign in to your account</h4>
                <p class="text-muted text-sm">Welcome back to EduTrack</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger bg-danger bg-opacity-10 border-0 text-danger text-sm py-2 px-3 mb-4 rounded">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="admin" required autofocus>
                </div>

                <div class="mb-4">
                    <div class="d-flex justify-content-between">
                        <label for="password" class="form-label">Password</label>
                    </div>
                    <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                </div>

                <div class="mb-4 bg-light p-3 rounded border" style="border-color: var(--border-subtle) !important;">
                    <label for="captcha" class="form-label mb-2">Security Check</label>
                    <div class="d-flex gap-2 align-items-center mb-2">
                        <img src="${pageContext.request.contextPath}/captcha" alt="Captcha" class="border rounded bg-white" style="height: 38px; border-color: #d1d5db !important;" id="captcha-img" />
                        <button type="button" class="btn btn-outline-secondary btn-sm p-1 d-flex align-items-center justify-content-center" style="width: 38px; height: 38px;" onclick="document.getElementById('captcha-img').src='${pageContext.request.contextPath}/captcha?'+new Date().getTime()" title="Reload Captcha">
                            <i class="fas fa-sync-alt"></i>
                        </button>
                    </div>
                    <input type="text" class="form-control form-control-sm" id="captcha" name="captcha" placeholder="Enter characters" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-3 py-2">Sign in</button>

                <div class="text-center text-sm">
                    <span class="text-muted">Don't have an account?</span>
                    <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-medium" style="color: var(--primary);">Register here</a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>