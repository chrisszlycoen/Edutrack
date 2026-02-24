<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!-- Welcome Card -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card shadow-sm border-0 bg-primary text-white">
                    <div class="card-body py-4">
                        <h4><i class="fas fa-user-graduate me-2"></i> Welcome, ${student != null ? student.fullName :
                            sessionScope.user.username}!</h4>
                        <p class="mb-0">Reg No: <strong>${sessionScope.user.username}</strong>
                            <c:if test="${student != null}"> | Class: <strong>${student.classRoom.name}</strong></c:if>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="row">
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 py-2 border-success border-4 border-start border-0">
                    <div class="card-body">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Attendance Rate</div>
                        <div class="h5 mb-0 font-weight-bold">${attendancePercent}%</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 py-2 border-primary border-4 border-start border-0">
                    <div class="card-body">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Days Present</div>
                        <div class="h5 mb-0 font-weight-bold">${presentCount}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 py-2 border-danger border-4 border-start border-0">
                    <div class="card-body">
                        <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Days Absent</div>
                        <div class="h5 mb-0 font-weight-bold">${absentCount}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm h-100 py-2 border-warning border-4 border-start border-0">
                    <div class="card-body">
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Discipline Cases</div>
                        <div class="h5 mb-0 font-weight-bold">${disciplineCount}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Attendance -->
        <div class="row">
            <div class="col-lg-7 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-calendar-check me-1"></i> Recent
                            Attendance</h6>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty recentAttendance}">
                                <div class="table-responsive">
                                    <table class="table table-striped mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentAttendance}" var="att">
                                                <tr>
                                                    <td>${att.attDate}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${att.status == 'PRESENT'}">
                                                                <span class="badge bg-success">Present</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">Absent</span>
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
                                <div class="p-4 text-center text-muted">
                                    <i class="fas fa-info-circle fa-2x mb-2"></i>
                                    <p>No attendance records yet.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Discipline Cases -->
            <div class="col-lg-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-warning"><i class="fas fa-gavel me-1"></i> Discipline Cases
                        </h6>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty disciplineCases}">
                                <div class="list-group list-group-flush">
                                    <c:forEach items="${disciplineCases}" var="dc">
                                        <div class="list-group-item">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1"><span
                                                        class="badge bg-warning text-dark">${dc.caseType}</span></h6>
                                                <small class="text-muted">${dc.caseDate}</small>
                                            </div>
                                            <p class="mb-1 small">${dc.description}</p>
                                            <c:if test="${not empty dc.actionTaken}">
                                                <small class="text-muted"><strong>Action:</strong>
                                                    ${dc.actionTaken}</small>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="p-4 text-center text-muted">
                                    <i class="fas fa-check-circle fa-2x mb-2 text-success"></i>
                                    <p>No discipline cases. Keep it up!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>