<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduTrack - OTP Verification</title>
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
        <div class="auth-logo mb-4">
            <div class="auth-logo-icon">
                <i class="fas fa-mobile-alt"></i>
            </div>
        </div>

        <div class="saas-card p-4 p-md-5">
            <div class="text-center mb-4">
                <h4 class="fw-bold mb-1">Enter Verification Code</h4>
                <p class="text-muted text-sm px-3">We just sent an authentication code to your email. Enter it below to sign in.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger bg-danger bg-opacity-10 border-0 text-danger text-sm py-2 px-3 mb-4 rounded text-center">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/2fa" method="post">
                <div class="mb-4">
                    <label for="code" class="form-label d-block text-center mb-2">6-Digit Code</label>
                    <input type="text" class="form-control form-control-lg text-center font-monospace fw-bold" id="code" name="code"
                        placeholder="000000" required autofocus maxlength="6"
                        style="letter-spacing: 8px; font-size: 1.25rem;">
                </div>
                
                <button type="submit" class="btn btn-primary w-100 mb-3 py-2">Verify & Sign In</button>
                
                <div class="text-center text-sm mt-2">
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none text-muted fw-medium border px-3 py-1 bg-light rounded" style="border-color: var(--border-subtle) !important;">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>