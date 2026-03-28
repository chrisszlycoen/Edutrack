<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="row g-4 mb-4">
    <!-- Clean Minimal Stats Cards -->
    <div class="col-md-3">
        <div class="saas-card d-flex align-items-center p-3">
            <div class="rounded-circle d-flex justify-content-center align-items-center me-3" style="width: 48px; height: 48px; background-color: #f3f4f6; color: var(--primary);">
                <i class="fas fa-users fs-5"></i>
            </div>
            <div>
                <p class="text-muted mb-0 fw-medium" style="font-size: 0.75rem;">Total Students</p>
                <h4 class="mb-0 fw-bold text-dark">${totalStudents == null ? '0' : totalStudents}</h4>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="saas-card d-flex align-items-center p-3">
            <div class="rounded-circle d-flex justify-content-center align-items-center me-3" style="width: 48px; height: 48px; background-color: #f3f4f6; color: var(--success);">
                <i class="fas fa-chalkboard fs-5"></i>
            </div>
            <div>
                <p class="text-muted mb-0 fw-medium" style="font-size: 0.75rem;">Total Classes</p>
                <h4 class="mb-0 fw-bold text-dark">${totalClasses == null ? '0' : totalClasses}</h4>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="saas-card d-flex align-items-center p-3">
            <div class="rounded-circle d-flex justify-content-center align-items-center me-3" style="width: 48px; height: 48px; background-color: #f3f4f6; color: var(--info);">
                <i class="fas fa-calendar-check fs-5"></i>
            </div>
            <div>
                <p class="text-muted mb-0 fw-medium" style="font-size: 0.75rem;">Today's Attendance</p>
                <h4 class="mb-0 fw-bold text-dark">${attendancePercentage == null ? '0' : attendancePercentage}%</h4>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="saas-card d-flex align-items-center p-3">
            <div class="rounded-circle d-flex justify-content-center align-items-center me-3" style="width: 48px; height: 48px; background-color: #f3f4f6; color: var(--warning);">
                <i class="fas fa-exclamation-triangle fs-5"></i>
            </div>
            <div>
                <p class="text-muted mb-0 fw-medium" style="font-size: 0.75rem;">Pending Discipline</p>
                <h4 class="mb-0 fw-bold text-dark">${pendingDiscipline == null ? '0' : pendingDiscipline}</h4>
            </div>
        </div>
    </div>
</div>

<div class="row g-4 mb-4">
    <div class="col-lg-8">
        <div class="saas-card h-100">
            <div class="saas-card-header border-0 pb-0">
                <h6 class="fw-bold mb-0">Overview</h6>
            </div>
            <div class="saas-card-body pt-3">
                <div class="mb-4">
                    <p class="fs-5 fw-medium text-dark mb-1">Welcome, ${sessionScope.user.username}.</p>
                    <p class="text-muted text-sm mb-4">Here's a snapshot of your institution today.</p>
                </div>
                
                <div style="height: 120px; border: 1px dashed var(--border-subtle); border-radius: var(--radius-md); display: flex; align-items: center; justify-content: center; background-color: #f9fafb; color: var(--text-muted); font-size: 0.875rem;">
                    [ Activity Chart Placeholder ]
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="saas-card h-100">
            <div class="saas-card-header">
                <h6 class="fw-bold mb-0">Quick Actions</h6>
            </div>
            <div class="p-3">
                <a href="${pageContext.request.contextPath}/students?action=new" class="action-item mb-2">
                    <div class="action-icon"><i class="fas fa-user-plus"></i></div>
                    <div class="flex-1">
                        <div class="fw-semibold text-sm text-dark">Enroll Student</div>
                        <div class="text-xs text-muted">Register a new admission</div>
                    </div>
                    <i class="fas fa-chevron-right text-muted mx-2" style="font-size: 0.75rem;"></i>
                </a>
                
                <a href="${pageContext.request.contextPath}/attendance" class="action-item mb-2">
                    <div class="action-icon"><i class="fas fa-clipboard-check"></i></div>
                    <div class="flex-1">
                        <div class="fw-semibold text-sm text-dark">Mark Attendance</div>
                        <div class="text-xs text-muted">Daily roll call</div>
                    </div>
                    <i class="fas fa-chevron-right text-muted mx-2" style="font-size: 0.75rem;"></i>
                </a>
                
                <a href="${pageContext.request.contextPath}/discipline?action=new" class="action-item">
                    <div class="action-icon"><i class="fas fa-gavel"></i></div>
                    <div class="flex-1">
                        <div class="fw-semibold text-sm text-dark">Report Incident</div>
                        <div class="text-xs text-muted">Log a new discipline case</div>
                    </div>
                    <i class="fas fa-chevron-right text-muted mx-2" style="font-size: 0.75rem;"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<c:if test="${sessionScope.user.role == 'ADMIN'}">
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="saas-card">
                <div class="saas-card-header d-flex justify-content-between align-items-center">
                    <h6 class="fw-bold mb-0">Security Settings</h6>
                </div>
                <div class="saas-card-body">
                    <c:choose>
                        <c:when test="${sessionScope.user.twoFactorEnabled}">
                            <div class="d-flex align-items-start mb-4">
                                <i class="fas fa-shield-check text-success fs-4 me-3 mt-1"></i>
                                <div>
                                    <h6 class="fw-bold text-dark mb-1 d-flex align-items-center">2FA is Enabled <span class="badge bg-success ms-2 px-2 py-1 align-middle" style="font-size: 0.65rem;">ACTIVE</span></h6>
                                    <p class="text-muted small mb-0">An OTP is sent to <strong>${sessionScope.user.email}</strong> on every login attempt.</p>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/dashboard" method="post">
                                <input type="hidden" name="action" value="disable2fa">
                                <button type="submit" class="btn btn-outline-secondary btn-sm fw-medium">
                                    Disable Security
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex align-items-start mb-4">
                                <i class="fas fa-shield-alt text-muted fs-4 me-3 mt-1"></i>
                                <div>
                                    <h6 class="fw-bold text-dark mb-1">Two-Factor Authentication</h6>
                                    <p class="text-muted small mb-0">Add an additional layer of security to your account.</p>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/dashboard" method="post" class="p-3 bg-light border rounded" style="border-color: var(--border-subtle) !important;">
                                <input type="hidden" name="action" value="enable2fa">
                                <div class="mb-3">
                                    <label for="email" class="form-label text-muted">Recovery Email</label>
                                    <input type="email" class="form-control" id="email" name="email"
                                        placeholder="admin@school.edu" required
                                        value="${sessionScope.user.email}">
                                </div>
                                <button type="submit" class="btn btn-primary btn-sm w-100 fw-medium">
                                    Enable 2FA
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</c:if>