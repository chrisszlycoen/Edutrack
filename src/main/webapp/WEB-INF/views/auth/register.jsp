<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduTrack - Register</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/globals.css" rel="stylesheet">
    <style>
        .auth-container { max-width: 520px; }
    </style>
</head>
<body class="auth-wrapper">

    <div class="auth-container">
        <div class="auth-logo mb-4">
            <div class="auth-logo-icon">
                <i class="fas fa-user-plus"></i>
            </div>
        </div>

        <div class="saas-card p-4 p-md-5">
            <div class="mb-4">
                <h4 class="fw-bold mb-1 text-center">Create Student Account</h4>
                <p class="text-muted text-sm text-center">Enter your details to register for the portal</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger bg-danger bg-opacity-10 border-0 text-danger text-sm py-2 px-3 mb-4 rounded">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" id="regForm">
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" class="form-control" value="${fullName}" required placeholder="John Doe">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Registration No</label>
                        <input type="text" name="regNo" class="form-control" value="${regNo}" required placeholder="STU-001">
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" name="dob" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Gender</label>
                        <select name="gender" class="form-select" required>
                            <option value="M">Male</option>
                            <option value="F">Female</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Class Assignment</label>
                    <select name="classId" class="form-select" required>
                        <option value="" disabled selected>Select a Class</option>
                        <c:forEach items="${classes}" var="cls">
                            <option value="${cls.id}">${cls.name} (${cls.level})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label text-dark">Email Verification</label>
                    <div class="input-group">
                        <input type="email" class="form-control border-end-0" id="email" name="email" placeholder="student@example.com" required>
                        <button type="button" class="btn btn-outline-secondary bg-light" id="sendOtpBtn" onclick="sendOTP()" style="border-color: #d1d5db;">
                            Send OTP
                        </button>
                    </div>
                    <div id="otpStatus" class="mt-1 text-xs"></div>
                </div>

                <div class="mb-3 bg-light p-3 rounded border" id="otpSection" style="display:none; border-color: #e5e7eb !important;">
                    <label class="form-label mb-1 text-sm">Verification Code</label>
                    <input type="text" class="form-control form-control-sm font-monospace text-center fw-medium tracking-widest" style="letter-spacing: 4px;" id="otp" name="otp" placeholder="000000" maxlength="6" required>
                    <div class="mt-1 text-xs text-muted text-center">Enter the 6-digit code sent to your email</div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required placeholder="••••••••">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control" required placeholder="••••••••">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 mb-3">Register Account</button>

                <div class="text-center text-sm mt-2">
                    <span class="text-muted">Already have an account?</span>
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-medium" style="color: var(--primary);">Sign in</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function sendOTP() {
            var email = document.getElementById('email').value;
            var btn = document.getElementById('sendOtpBtn');
            var status = document.getElementById('otpStatus');

            if (!email || !email.includes('@')) {
                status.innerHTML = '<span class="text-danger fw-medium">Please enter a valid email.</span>';
                return;
            }

            btn.disabled = true;
            btn.innerHTML = 'Sending...';
            status.innerHTML = '';

            fetch('${pageContext.request.contextPath}/register-otp', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'email=' + encodeURIComponent(email)
            })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (data.success) {
                    status.innerHTML = '<span class="text-success fw-medium">' + data.message + '</span>';
                    document.getElementById('otpSection').style.display = 'block';
                    var seconds = 60;
                    var interval = setInterval(function () {
                        seconds--;
                        btn.innerHTML = 'Resend (' + seconds + 's)';
                        if (seconds <= 0) {
                            clearInterval(interval);
                            btn.disabled = false;
                            btn.innerHTML = 'Resend OTP';
                        }
                    }, 1000);
                } else {
                    status.innerHTML = '<span class="text-danger fw-medium">' + data.message + '</span>';
                    btn.disabled = false;
                    btn.innerHTML = 'Send OTP';
                }
            })
            .catch(function () {
                status.innerHTML = '<span class="text-danger fw-medium">Network error. Try again.</span>';
                btn.disabled = false;
                btn.innerHTML = 'Send OTP';
            });
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>