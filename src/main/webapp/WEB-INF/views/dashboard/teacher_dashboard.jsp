<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!-- Welcome -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="alert alert-info mb-0">
                    <h4><i class="fas fa-chalkboard-teacher me-2"></i> Welcome, ${sessionScope.user.name != null ?
                        sessionScope.user.name : sessionScope.user.username}!</h4>
                    <p class="mb-0">You can view students, mark attendance, and report discipline cases.</p>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card text-white bg-primary shadow-sm h-100">
                    <div class="card-body text-center py-4">
                        <i class="fas fa-user-graduate fa-3x mb-3"></i>
                        <h5 class="card-title">View Students</h5>
                        <p class="card-text">Browse the student list.</p>
                        <a href="${pageContext.request.contextPath}/students" class="btn btn-light btn-sm">
                            <i class="fas fa-arrow-right me-1"></i> Go
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card text-white bg-success shadow-sm h-100">
                    <div class="card-body text-center py-4">
                        <i class="fas fa-calendar-check fa-3x mb-3"></i>
                        <h5 class="card-title">Mark Attendance</h5>
                        <p class="card-text">Mark student attendance for today.</p>
                        <a href="${pageContext.request.contextPath}/attendance" class="btn btn-light btn-sm">
                            <i class="fas fa-arrow-right me-1"></i> Go
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card text-white bg-warning shadow-sm h-100">
                    <div class="card-body text-center py-4">
                        <i class="fas fa-gavel fa-3x mb-3"></i>
                        <h5 class="card-title">Report Issue</h5>
                        <p class="card-text">Report a discipline case.</p>
                        <a href="${pageContext.request.contextPath}/discipline?action=new" class="btn btn-light btn-sm">
                            <i class="fas fa-arrow-right me-1"></i> Go
                        </a>
                    </div>
                </div>
            </div>
        </div>