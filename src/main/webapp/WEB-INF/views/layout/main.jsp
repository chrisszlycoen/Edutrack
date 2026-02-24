<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EduTrack - Admin Dashboard</title>
            <!-- Bootstrap 5 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- FontAwesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            <style>
                .sidebar {
                    min-height: 100vh;
                    background-color: #212529;
                    color: white;
                    transition: all 0.3s;
                }

                .sidebar-link {
                    color: rgba(255, 255, 255, 0.75);
                    text-decoration: none;
                    padding: 10px 15px;
                    display: block;
                    border-radius: 5px;
                    margin-bottom: 5px;
                }

                .sidebar-link:hover,
                .sidebar-link.active {
                    background-color: rgba(255, 255, 255, 0.1);
                    color: white;
                }

                .sidebar-link i {
                    width: 25px;
                    text-align: center;
                }

                .main-content {
                    background-color: #f8f9fa;
                    min-height: 100vh;
                }

                .topbar {
                    background-color: white;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                    padding: 10px 20px;
                }
            </style>
        </head>

        <body>
            <div class="d-flex">
                <!-- Sidebar -->
                <div class="sidebar d-flex flex-column flex-shrink-0 p-3" style="width: 250px;">
                    <c:set var="homeDash"
                        value="${sessionScope.user.role == 'STUDENT' ? '/student-dashboard' : (sessionScope.user.role == 'TEACHER' ? '/teacher-dashboard' : '/dashboard')}" />
                    <a href="${pageContext.request.contextPath}${homeDash}"
                        class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                        <i class="fas fa-graduation-cap fa-2x me-2"></i>
                        <span class="fs-4">EduTrack</span>
                    </a>
                    <hr>
                    <ul class="nav nav-pills flex-column mb-auto">
                        <!-- Dashboard link (role-specific) -->
                        <li class="nav-item">
                            <c:choose>
                                <c:when test="${sessionScope.user.role == 'STUDENT'}">
                                    <a href="${pageContext.request.contextPath}/student-dashboard"
                                        class="sidebar-link ${currentPage == 'student-dashboard' ? 'active' : ''}">
                                        <i class="fas fa-home"></i> My Dashboard
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.user.role == 'TEACHER'}">
                                    <a href="${pageContext.request.contextPath}/teacher-dashboard"
                                        class="sidebar-link ${currentPage == 'teacher-dashboard' ? 'active' : ''}">
                                        <i class="fas fa-home"></i> Dashboard
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/dashboard"
                                        class="sidebar-link ${currentPage == 'dashboard' ? 'active' : ''}">
                                        <i class="fas fa-home"></i> Dashboard
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </li>

                        <!-- Admin & Teacher: Student list (read-only for teacher) -->
                        <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                            <li>
                                <a href="${pageContext.request.contextPath}/students"
                                    class="sidebar-link ${currentPage == 'students' ? 'active' : ''}">
                                    <i class="fas fa-user-graduate"></i> Students
                                </a>
                            </li>
                        </c:if>

                        <!-- Admin only: Classes CRUD -->
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <li>
                                <a href="${pageContext.request.contextPath}/classes"
                                    class="sidebar-link ${currentPage == 'classes' ? 'active' : ''}">
                                    <i class="fas fa-chalkboard-teacher"></i> Classes
                                </a>
                            </li>
                        </c:if>

                        <!-- Admin & Teacher: Attendance -->
                        <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                            <li>
                                <a href="${pageContext.request.contextPath}/attendance"
                                    class="sidebar-link ${currentPage == 'attendance' ? 'active' : ''}">
                                    <i class="fas fa-calendar-check"></i> Attendance
                                </a>
                            </li>
                        </c:if>

                        <!-- Admin & Teacher: Discipline -->
                        <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                            <li>
                                <a href="${pageContext.request.contextPath}/discipline"
                                    class="sidebar-link ${currentPage == 'discipline' ? 'active' : ''}">
                                    <i class="fas fa-gavel"></i> Discipline
                                </a>
                            </li>
                        </c:if>

                        <!-- Admin only: Manage Staff -->
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/staff"
                                    class="sidebar-link ${currentPage == 'staff' ? 'active' : ''}">
                                    <i class="fas fa-users-cog"></i> Manage Staff
                                </a>
                            </li>
                        </c:if>
                    </ul>

                    <hr>
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                            id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center text-white me-2"
                                style="width: 32px; height: 32px;">
                                ${sessionScope.user.username.charAt(0)}
                            </div>
                            <strong>${sessionScope.user.username}</strong>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Sign out</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="flex-grow-1 main-content">
                    <!-- Topbar -->
                    <div class="topbar d-flex justify-content-between align-items-center mb-4">
                        <h4 class="m-0">${pageTitle}</h4>
                        <div>
                            <span class="badge bg-secondary">${sessionScope.user.role}</span>
                        </div>
                    </div>

                    <!-- Page Content -->
                    <div class="container-fluid px-4">
                        <jsp:include page="${contentPage}" />
                    </div>
                </div>
            </div>

            <!-- Bootstrap 5 JS Bundle -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Auto-hide alerts after 5 seconds
                setTimeout(function () {
                    var alerts = document.querySelectorAll('.alert');
                    alerts.forEach(function (alert) {
                        var bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    });
                }, 5000);
            </script>
        </body>

        </html>