<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="row">
            <!-- Stats Cards -->
            <div class="col-md-3 mb-4">
                <div
                    class="card shadow-sm border-left-primary h-100 py-2 border-primary border-4 border-start border-0">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Total Students</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalStudents == null ? '0' :
                                    totalStudents}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-user-graduate fa-2x text-gray-300 text-primary opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 py-2 border-success border-4 border-start border-0">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                    Total Classes</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalClasses == null ? '0' :
                                    totalClasses}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-chalkboard fa-2x text-gray-300 text-success opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 py-2 border-info border-4 border-start border-0">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                    Today's Attendance</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${attendancePercentage == null ? '0'
                                    : attendancePercentage}%</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-clipboard-list fa-2x text-gray-300 text-info opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 py-2 border-warning border-4 border-start border-0">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                    Pending Discipline</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${pendingDiscipline == null ? '0' :
                                    pendingDiscipline}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-exclamation-triangle fa-2x text-gray-300 text-warning opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8 mb-4">
                <div class="card shadow-sm mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">System Info</h6>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info">
                            <h4><i class="fas fa-user-circle"></i> Welcome, ${sessionScope.user.username}!</h4>
                            <p>Select an option from the sidebar to manage the system.</p>
                        </div>
                        <p class="mb-0">You are logged in as <span
                                class="badge bg-secondary">${sessionScope.user.role}</span>. Use the sidebar to navigate
                            to different modules.</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 mb-4">
                <div class="card shadow-sm mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Quick Actions</h6>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/students?action=new"
                                class="btn btn-primary btn-sm">
                                <i class="fas fa-plus me-1"></i> Add Student
                            </a>
                            <a href="${pageContext.request.contextPath}/attendance" class="btn btn-success btn-sm">
                                <i class="fas fa-check me-1"></i> Mark Attendance
                            </a>
                            <a href="${pageContext.request.contextPath}/discipline?action=new"
                                class="btn btn-warning btn-sm">
                                <i class="fas fa-file-alt me-1"></i> Report Case
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header py-3 bg-dark text-white">
                            <h6 class="m-0 font-weight-bold"><i class="fas fa-shield-alt me-2"></i>Security Settings —
                                Two-Factor Authentication</h6>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${sessionScope.user.twoFactorEnabled}">
                                    <div class="alert alert-success mb-3">
                                        <i class="fas fa-check-circle me-1"></i> <strong>2FA is ENABLED</strong>
                                        <br><small class="text-muted">OTP is sent to
                                            <strong>${sessionScope.user.email}</strong> on every login.</small>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/dashboard" method="post">
                                        <input type="hidden" name="action" value="disable2fa">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="fas fa-times me-1"></i> Disable 2FA
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning mb-3">
                                        <i class="fas fa-exclamation-triangle me-1"></i> <strong>2FA is
                                            DISABLED</strong>
                                        <br><small>Enable it to receive a one-time password via email every time you
                                            login.</small>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/dashboard" method="post">
                                        <input type="hidden" name="action" value="enable2fa">
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Your Email Address</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                                <input type="email" class="form-control" id="email" name="email"
                                                    placeholder="Enter your email" required
                                                    value="${sessionScope.user.email}">
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-success btn-sm">
                                            <i class="fas fa-lock me-1"></i> Enable 2FA
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>