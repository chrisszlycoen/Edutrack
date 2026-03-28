<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="row mb-4">
    <div class="col-12">
        <div class="saas-card" style="border-left: 4px solid var(--primary);">
            <div class="saas-card-body d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h5 class="fw-bold text-dark mb-1">Welcome back, ${student != null ? student.fullName : sessionScope.user.username}</h5>
                    <p class="text-muted mb-0 small">Overview of your academic progress</p>
                </div>
                <div class="d-flex flex-wrap gap-2">
                    <span class="badge border bg-white text-dark py-2 px-3 fw-medium font-monospace" style="border-color: var(--border-subtle) !important;">
                        ID: ${sessionScope.user.username}
                    </span>
                    <c:if test="${student != null}">
                        <span class="badge border bg-white text-dark py-2 px-3 fw-medium" style="border-color: var(--border-subtle) !important;">
                            Class: ${student.classRoom.name}
                        </span>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row g-4 mb-4">
    <div class="col-md-3">
        <div class="saas-card p-3">
            <p class="text-muted fw-semibold text-xs text-uppercase tracking-wide mb-1">Attendance Rate</p>
            <div class="d-flex align-items-end gap-2">
                <h3 class="fw-bold mb-0 text-dark">${attendancePercent}%</h3>
                <span class="text-success small fw-medium mb-1"><i class="fas fa-arrow-trend-up"></i></span>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="saas-card p-3">
            <p class="text-muted fw-semibold text-xs text-uppercase tracking-wide mb-1">Days Present</p>
            <h3 class="fw-bold mb-0 text-dark">${presentCount}</h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="saas-card p-3">
            <p class="text-muted fw-semibold text-xs text-uppercase tracking-wide mb-1">Days Absent</p>
            <h3 class="fw-bold mb-0 text-dark">${absentCount}</h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="saas-card p-3">
            <p class="text-muted fw-semibold text-xs text-uppercase tracking-wide mb-1">Discipline Logs</p>
            <h3 class="fw-bold mb-0 text-dark">${disciplineCount}</h3>
        </div>
    </div>
</div>

<div class="row g-4">
    <div class="col-lg-8">
        <div class="saas-card h-100">
            <div class="saas-card-header">
                <h6 class="fw-bold mb-0">Attendance History</h6>
            </div>
            <div class="p-0">
                <c:choose>
                    <c:when test="${not empty recentAttendance}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0 border-0">
                                <thead class="bg-light text-muted" style="font-size: 0.75rem;">
                                    <tr>
                                        <th class="ps-4 py-3 fw-medium border-0">Date</th>
                                        <th class="pe-4 py-3 fw-medium border-0 text-end">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${recentAttendance}" var="att">
                                        <tr style="border-bottom: 1px solid var(--border-subtle);">
                                            <td class="ps-4 py-3 text-dark fw-medium" style="font-size: 0.875rem;">${att.attDate}</td>
                                            <td class="pe-4 py-3 text-end">
                                                <c:choose>
                                                    <c:when test="${att.status == 'PRESENT'}">
                                                        <span class="badge-soft" style="background-color: #ecfdf5; color: #059669;">Present</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-soft" style="background-color: #fef2f2; color: #dc2626;">Absent</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center text-muted">
                            <div class="text-muted mb-2"><i class="fas fa-inbox fs-3"></i></div>
                            <p class="text-sm">No attendance records found.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="saas-card h-100">
            <div class="saas-card-header">
                <h6 class="fw-bold mb-0">Discipline Log</h6>
            </div>
            <div class="p-0">
                <c:choose>
                    <c:when test="${not empty disciplineCases}">
                        <div class="list-group list-group-flush border-0">
                            <c:forEach items="${disciplineCases}" var="dc">
                                <div class="list-group-item px-4 py-3" style="border-bottom: 1px solid var(--border-subtle);">
                                    <div class="d-flex justify-content-between align-items-baseline mb-1">
                                        <span class="badge-soft" style="background-color: #fffbeb; color: #d97706;">${dc.caseType}</span>
                                        <span class="text-muted small">${dc.caseDate}</span>
                                    </div>
                                    <p class="text-dark small mb-2 mt-2">${dc.description}</p>
                                    <c:if test="${not empty dc.actionTaken}">
                                        <div class="bg-light p-2 rounded text-xs text-muted border border-1 border-secondary border-opacity-10">
                                            <span class="fw-medium text-dark">Action:</span> ${dc.actionTaken}
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center text-muted">
                            <div class="mb-2"><i class="fas fa-check-circle fs-3 text-success"></i></div>
                            <p class="text-sm">No discipline logs. Keep it up!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>