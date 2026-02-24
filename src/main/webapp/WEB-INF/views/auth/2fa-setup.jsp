<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EduTrack - 2FA Setup</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                body {
                    background-color: #f8f9fa;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .setup-card {
                    width: 100%;
                    max-width: 500px;
                    padding: 2rem;
                    border-radius: 10px;
                    background: white;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                }

                .setup-header {
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .setup-header i {
                    color: #0d6efd;
                }

                .secret-key {
                    font-family: monospace;
                    font-size: 1.1rem;
                    letter-spacing: 2px;
                    background: #f0f0f0;
                    padding: 10px;
                    border-radius: 5px;
                    text-align: center;
                    word-break: break-all;
                }

                .step-number {
                    background: #0d6efd;
                    color: white;
                    border-radius: 50%;
                    width: 28px;
                    height: 28px;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: bold;
                    margin-right: 8px;
                }
            </style>
        </head>

        <body>
            <div class="setup-card">
                <div class="setup-header">
                    <i class="fas fa-shield-alt fa-3x mb-3"></i>
                    <h3>Two-Factor Authentication</h3>
                </div>

                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${sessionScope.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="message" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="error" scope="session" />
                </c:if>

                <c:choose>
                    <c:when test="${twoFactorEnabled}">
                        <div class="text-center mb-4">
                            <span class="badge bg-success fs-6"><i class="fas fa-check-circle"></i> 2FA is
                                ENABLED</span>
                        </div>
                        <p class="text-muted text-center">Your account is protected with two-factor authentication.</p>
                        <form action="${pageContext.request.contextPath}/2fa-setup" method="post">
                            <input type="hidden" name="action" value="disable">
                            <div class="d-grid gap-2 mt-3">
                                <button type="submit" class="btn btn-danger">Disable 2FA</button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center mb-3">
                            <span class="badge bg-warning text-dark fs-6"><i class="fas fa-exclamation-triangle"></i>
                                2FA is DISABLED</span>
                        </div>

                        <div class="mb-3">
                            <p><span class="step-number">1</span> Open your authenticator app (Google Authenticator,
                                Authy, etc.)</p>
                        </div>

                        <div class="mb-3">
                            <p><span class="step-number">2</span> Add a new account and enter this secret key manually:
                            </p>
                            <div class="secret-key">${secret}</div>
                            <small class="text-muted d-block mt-1 text-center">Account name:
                                <strong>${username}@EduTrack</strong></small>
                        </div>

                        <div class="mb-3">
                            <p><span class="step-number">3</span> Enter the 6-digit code from your app to verify:</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/2fa-setup" method="post">
                            <input type="hidden" name="action" value="enable">
                            <input type="hidden" name="secret" value="${secret}">
                            <div class="mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    <input type="text" class="form-control" name="code" placeholder="Enter 6-digit code"
                                        required maxlength="6" pattern="[0-9]{6}">
                                </div>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">Enable 2FA</button>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>

                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none">Back to
                        Dashboard</a>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>