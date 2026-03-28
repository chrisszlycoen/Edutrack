<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduTrack - Setup 2FA</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/globals.css" rel="stylesheet">
    <style>
        .auth-container { max-width: 500px; }
        
        .step-indicator {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            position: relative;
        }
        
        .step {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: var(--bg-surface);
            border: 2px solid var(--border-subtle);
            color: var(--text-muted);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.875rem;
            z-index: 2;
        }
        
        .step.active {
            border-color: var(--primary);
            background-color: var(--primary);
            color: white;
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }
        
        .step-line {
            flex: 1;
            height: 2px;
            background-color: var(--border-subtle);
            margin: 0 0.5rem;
            z-index: 1;
        }
    </style>
</head>
<body class="auth-wrapper">

    <div class="auth-container">
        <div class="auth-logo mb-4">
            <div class="auth-logo-icon">
                <i class="fas fa-shield-alt"></i>
            </div>
        </div>

        <div class="saas-card p-4 p-md-5">
            <div class="text-center mb-4">
                <h4 class="fw-bold mb-1">Set up Two-Factor Authentication</h4>
                <p class="text-muted text-sm">Secure your account in two simple steps</p>
            </div>

            <div class="step-indicator">
                <div class="step active">1</div>
                <div class="step-line"></div>
                <div class="step text-muted">2</div>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger bg-danger bg-opacity-10 border-0 text-danger text-sm py-2 px-3 mb-4 rounded text-center">
                    ${error}
                </div>
            </c:if>

            <div class="bg-light p-4 rounded mb-4 text-center border" style="border-color: var(--border-subtle) !important;">
                <div class="mb-3">
                    <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-white shadow-sm" style="width: 56px; height: 56px; color: var(--primary);">
                        <i class="fas fa-envelope-open-text fs-4"></i>
                    </div>
                </div>
                <h6 class="fw-bold text-dark mb-2">Verify your email address</h6>
                <p class="text-muted small mb-0">We will send verification codes to:</p>
                <div class="mt-2 text-dark fw-bold font-monospace bg-white border py-2 px-3 rounded d-inline-block shadow-sm">
                    ${sessionScope.user.email}
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/2fa-setup" method="post">
                <div class="mb-4">
                    <label for="password" class="form-label">Confirm your password to continue</label>
                    <input type="password" class="form-control" id="password" name="password" 
                        placeholder="••••••••" required autofocus>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 py-2 mb-3">Send Verification Code</button>
                
                <div class="text-center text-sm mt-3">
                    <a href="${pageContext.request.contextPath}${sessionScope.user.role == 'STUDENT' ? '/student-dashboard' : (sessionScope.user.role == 'TEACHER' ? '/teacher-dashboard' : '/dashboard')}" class="text-decoration-none text-muted fw-medium border px-3 py-1 bg-light rounded" style="border-color: var(--border-subtle) !important;">
                        Cancel Setup
                    </a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>