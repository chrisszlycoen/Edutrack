<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduTrack</title>
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom Clean SaaS CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/globals.css" rel="stylesheet">

    <style>
        body, html {
            height: 100%;
            margin: 0;
            background-color: var(--bg-app);
            overflow: hidden;
        }
        
        .app-layout {
            display: flex;
            height: 100vh;
        }

        /* Clean Sidebar */
        .sidebar {
            width: 260px;
            background-color: var(--bg-sidebar);
            display: flex;
            flex-direction: column;
            color: #9ca3af; /* Tailwind gray-400 */
        }

        .sidebar-header {
            height: 64px;
            padding: 0 1.5rem;
            display: flex;
            align-items: center;
            font-size: 1.25rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .sidebar-header i {
            color: var(--primary);
            margin-right: 0.75rem;
        }

        .sidebar-nav {
            flex: 1;
            padding: 1.5rem 1rem;
            overflow-y: auto;
        }

        .nav-section {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #6b7280; /* Tailwind gray-500 */
            margin: 1.5rem 0 0.5rem 0.75rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.5rem 0.75rem;
            color: #d1d5db; /* gray-300 */
            text-decoration: none;
            border-radius: var(--radius-md);
            margin-bottom: 0.25rem;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.15s ease;
        }

        .nav-link:hover {
            background-color: var(--bg-sidebar-hover);
            color: white;
        }

        .nav-link.active {
            background-color: var(--bg-sidebar-hover);
            color: white;
        }

        .nav-link i {
            width: 1.25rem;
            margin-right: 0.75rem;
            font-size: 1rem;
            text-align: center;
        }

        /* Active indicator line */
        .nav-link.active::before {
            content: '';
            position: absolute;
            left: 0;
            width: 4px;
            height: 1.5rem;
            background-color: var(--primary);
            border-top-right-radius: 4px;
            border-bottom-right-radius: 4px;
        }

        .sidebar-footer {
            padding: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* User Profile in Sidebar */
        .user-dropdown-toggle {
            display: flex;
            align-items: center;
            width: 100%;
            padding: 0.5rem;
            border-radius: var(--radius-md);
            color: white;
            text-decoration: none;
            background: transparent;
            border: none;
            transition: background 0.15s;
        }

        .user-dropdown-toggle:hover {
            background-color: var(--bg-sidebar-hover);
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.875rem;
            margin-right: 0.75rem;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            text-align: left;
            flex: 1;
        }

        .user-name {
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.2;
        }

        .user-role {
            font-size: 0.75rem;
            color: #9ca3af;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
            background-color: var(--bg-app);
        }

        .topbar {
            height: 64px;
            background-color: var(--bg-surface);
            border-bottom: 1px solid var(--border-subtle);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
            box-shadow: 0 1px 2px 0 rgba(0,0,0,0.02);
            z-index: 10;
        }

        .page-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-main);
            margin: 0;
        }

        .content-scroll {
            flex: 1;
            overflow-y: auto;
            padding: 2rem;
        }
    </style>
</head>

<body>
    <div class="app-layout">
        
        <!-- Minimal Sidebar -->
        <aside class="sidebar position-relative">
            <c:set var="homeDash" value="${sessionScope.user.role == 'STUDENT' ? '/student-dashboard' : (sessionScope.user.role == 'TEACHER' ? '/teacher-dashboard' : '/dashboard')}" />
            
            <a href="${pageContext.request.contextPath}${homeDash}" class="sidebar-header">
                <i class="fas fa-layer-group"></i> EduTrack
            </a>

            <nav class="sidebar-nav">
                
                <div class="nav-section" style="margin-top: 0;">Main</div>
                
                <c:choose>
                    <c:when test="${sessionScope.user.role == 'STUDENT'}">
                        <a href="${pageContext.request.contextPath}/student-dashboard" class="nav-link ${currentPage == 'student-dashboard' ? 'active' : ''}">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'TEACHER'}">
                        <a href="${pageContext.request.contextPath}/teacher-dashboard" class="nav-link ${currentPage == 'teacher-dashboard' ? 'active' : ''}">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link ${currentPage == 'dashboard' ? 'active' : ''}">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                    </c:otherwise>
                </c:choose>

                <!-- Academic -->
                <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                    <div class="nav-section">Academic</div>
                    
                    <a href="${pageContext.request.contextPath}/students" class="nav-link ${currentPage == 'students' ? 'active' : ''}">
                        <i class="fas fa-users"></i> Students
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/attendance" class="nav-link ${currentPage == 'attendance' ? 'active' : ''}">
                        <i class="fas fa-check-square"></i> Attendance
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/discipline" class="nav-link ${currentPage == 'discipline' ? 'active' : ''}">
                        <i class="fas fa-clipboard-list"></i> Discipline
                    </a>
                </c:if>

                <!-- Admin -->
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <div class="nav-section">Administration</div>
                    
                    <a href="${pageContext.request.contextPath}/classes" class="nav-link ${currentPage == 'classes' ? 'active' : ''}">
                        <i class="fas fa-chalkboard"></i> Classes
                    </a>

                    <a href="${pageContext.request.contextPath}/staff" class="nav-link ${currentPage == 'staff' ? 'active' : ''}">
                        <i class="fas fa-user-shield"></i> Staff
                    </a>
                </c:if>

            </nav>

            <div class="sidebar-footer">
                <div class="dropdown">
                    <button class="user-dropdown-toggle" id="userMenu" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="user-avatar">
                            ${sessionScope.user.username.substring(0,1).toUpperCase()}
                        </div>
                        <div class="user-info">
                            <span class="user-name">${sessionScope.user.username}</span>
                            <span class="user-role">${sessionScope.user.role}</span>
                        </div>
                        <i class="fas fa-chevron-up text-muted ps-2" style="font-size: 0.75rem;"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-dark shadow" aria-labelledby="userMenu" style="width: 100%; border-radius: var(--radius-md); background-color: var(--bg-sidebar-hover); border: 1px solid rgba(255,255,255,0.1);">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/change-password" style="font-size: 0.875rem;">
                                Account Settings
                            </a>
                        </li>
                        <li><hr class="dropdown-divider border-secondary opacity-25"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout" style="font-size: 0.875rem;">
                                Sign out
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </aside>

        <!-- Main -->
        <main class="main-content">
            
            <header class="topbar">
                <h1 class="page-title">${pageTitle}</h1>
                <div class="d-none d-sm-block">
                    <span class="badge" style="background-color: #f3f4f6; color: #4b5563; border: 1px solid #e5e7eb; font-weight: 500; padding: 0.35rem 0.75rem; border-radius: 9999px;">
                        ${sessionScope.user.role} workspace
                    </span>
                </div>
            </header>

            <div class="content-scroll">
                <jsp:include page="${contentPage}" />
            </div>
            
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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