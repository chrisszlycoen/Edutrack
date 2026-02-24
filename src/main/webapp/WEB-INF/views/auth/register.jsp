<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EduTrack - Student Registration</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                body {
                    background-color: #f8f9fa;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                }

                .card {
                    width: 100%;
                    max-width: 600px;
                }
            </style>
        </head>

        <body>
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <i class="fas fa-user-plus fa-2x text-primary mb-2"></i>
                        <h4>Student Registration</h4>
                        <p class="text-muted small">Create your account to access the portal</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post" id="regForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="fullName" class="form-control" value="${fullName}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Registration No</label>
                                <input type="text" name="regNo" class="form-control" value="${regNo}" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Date of Birth</label>
                                <input type="date" name="dob" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Gender</label>
                                <select name="gender" class="form-select" required>
                                    <option value="M">Male</option>
                                    <option value="F">Female</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Class</label>
                            <select name="classId" class="form-select" required>
                                <option value="">Select a Class</option>
                                <c:forEach items="${classes}" var="cls">
                                    <option value="${cls.id}">${cls.name} (${cls.level})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Email Verification Section -->
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email"
                                    placeholder="Enter your email" required>
                                <button type="button" class="btn btn-outline-primary" id="sendOtpBtn"
                                    onclick="sendOTP()">
                                    <i class="fas fa-paper-plane me-1"></i> Send OTP
                                </button>
                            </div>
                            <div id="otpStatus" class="mt-1"></div>
                        </div>

                        <div class="mb-3" id="otpSection" style="display:none;">
                            <label class="form-label">Enter OTP</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                                <input type="text" class="form-control" id="otp" name="otp" placeholder="6-digit code"
                                    maxlength="6" required>
                            </div>
                            <small class="text-muted">Check your email for the 6-digit verification code.</small>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Confirm Password</label>
                                <input type="password" name="confirmPassword" class="form-control" required>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success">Register</button>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-link">Already have an
                                account? Login</a>
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
                        status.innerHTML = '<small class="text-danger">Please enter a valid email first.</small>';
                        return;
                    }

                    btn.disabled = true;
                    btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Sending...';
                    status.innerHTML = '';

                    fetch('${pageContext.request.contextPath}/register-otp', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: 'email=' + encodeURIComponent(email)
                    })
                        .then(function (r) { return r.json(); })
                        .then(function (data) {
                            if (data.success) {
                                status.innerHTML = '<small class="text-success"><i class="fas fa-check-circle"></i> ' + data.message + '</small>';
                                document.getElementById('otpSection').style.display = 'block';
                                // Countdown before allowing resend
                                var seconds = 60;
                                var interval = setInterval(function () {
                                    seconds--;
                                    btn.innerHTML = 'Resend (' + seconds + 's)';
                                    if (seconds <= 0) {
                                        clearInterval(interval);
                                        btn.disabled = false;
                                        btn.innerHTML = '<i class="fas fa-paper-plane me-1"></i> Resend OTP';
                                    }
                                }, 1000);
                            } else {
                                status.innerHTML = '<small class="text-danger"><i class="fas fa-times-circle"></i> ' + data.message + '</small>';
                                btn.disabled = false;
                                btn.innerHTML = '<i class="fas fa-paper-plane me-1"></i> Send OTP';
                            }
                        })
                        .catch(function () {
                            status.innerHTML = '<small class="text-danger">Network error. Try again.</small>';
                            btn.disabled = false;
                            btn.innerHTML = '<i class="fas fa-paper-plane me-1"></i> Send OTP';
                        });
                }
            </script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>