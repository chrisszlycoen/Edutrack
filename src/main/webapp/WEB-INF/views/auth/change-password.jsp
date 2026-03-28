<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduTrack - Change Password</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/globals.css" rel="stylesheet">
    <style>
        .auth-container { max-width: 460px; }
    </style>
</head>
<body class="auth-wrapper">

    <div class="auth-container">
        
        <div class="mb-4">
            <a href="${pageContext.request.contextPath}${sessionScope.user.role == 'STUDENT' ? '/student-dashboard' : (sessionScope.user.role == 'TEACHER' ? '/teacher-dashboard' : '/dashboard')}" class="text-decoration-none text-muted text-sm fw-medium d-inline-flex align-items-center bg-white px-3 py-2 border rounded shadow-sm" style="border-color: var(--border-subtle) !important;">
                <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
            </a>
        </div>

        <div class="saas-card p-4 p-md-5">
            <div class="mb-4">
                <div class="d-inline-flex justify-content-center align-items-center rounded bg-light border mb-3" style="width: 48px; height: 48px; border-color: var(--border-subtle) !important; color: var(--text-main);">
                    <i class="fas fa-key fs-5"></i>
                </div>
                <h4 class="fw-bold mb-1">Update Password</h4>
                <p class="text-muted text-sm">Ensure your account is using a long, random password to stay secure.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger bg-danger bg-opacity-10 border-0 text-danger text-sm py-2 px-3 mb-4 rounded">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success bg-success bg-opacity-10 border-0 text-success text-sm py-2 px-3 mb-4 rounded d-flex align-items-center">
                    <i class="fas fa-check-circle me-2"></i> ${message}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/change-password" method="post">
                <div class="mb-4">
                    <label for="currentPassword" class="form-label">Current Password</label>
                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required autofocus placeholder="••••••••">
                </div>

                <hr class="border-secondary opacity-25 mb-4">

                <div class="mb-3">
                    <label for="newPassword" class="form-label">New Password</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required placeholder="••••••••">
                </div>

                <div class="mb-4">
                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required placeholder="••••••••">
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2">Update Password</button>
            </form>
        </div>
    </div>

</body>
</html>