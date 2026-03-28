<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="row mb-4">
    <div class="col-12">
        <div class="saas-card bg-white border-0" style="box-shadow: none;">
            <div class="pb-3 pt-2">
                <h3 class="fw-bold text-dark mb-1">Teacher Dashboard</h3>
                <p class="text-muted mb-0">Manage classes, attendance, and discipline cases from your workspace.</p>
            </div>
        </div>
    </div>
</div>

<div class="row g-4 mb-4">
    <div class="col-md-4">
        <div class="saas-card h-100 position-relative transition-all" style="transition: all 0.2s;">
            <div class="saas-card-body">
                <div class="mb-4">
                    <div class="rounded bg-light text-primary d-inline-flex align-items-center justify-content-center border" style="width: 40px; height: 40px; border-color: var(--border-subtle) !important;">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <h5 class="fw-bold text-dark mb-2">Student Directory</h5>
                <p class="text-muted text-sm mb-4">Access student profiles, view academic details, and manage class assignments.</p>
                <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary btn-sm fw-medium">
                    View Directory
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="saas-card h-100 position-relative" style="transition: all 0.2s;">
            <div class="saas-card-body">
                <div class="mb-4">
                    <div class="rounded bg-light text-success d-inline-flex align-items-center justify-content-center border" style="width: 40px; height: 40px; border-color: var(--border-subtle) !important;">
                        <i class="fas fa-clipboard-check"></i>
                    </div>
                </div>
                <h5 class="fw-bold text-dark mb-2">Attendance Marking</h5>
                <p class="text-muted text-sm mb-4">Record daily presence logs for your classes quickly and efficiently.</p>
                <a href="${pageContext.request.contextPath}/attendance" class="btn btn-outline-secondary btn-sm fw-medium">
                    Mark Register
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="saas-card h-100 position-relative" style="transition: all 0.2s;">
            <div class="saas-card-body">
                <div class="mb-4">
                    <div class="rounded bg-light text-warning d-inline-flex align-items-center justify-content-center border" style="width: 40px; height: 40px; border-color: var(--border-subtle) !important;">
                        <i class="fas fa-gavel"></i>
                    </div>
                </div>
                <h5 class="fw-bold text-dark mb-2">Discipline Center</h5>
                <p class="text-muted text-sm mb-4">Log new discipline incidents and track student behavior cases over time.</p>
                <a href="${pageContext.request.contextPath}/discipline?action=new" class="btn btn-outline-secondary btn-sm fw-medium">
                    Log Incident
                </a>
            </div>
        </div>
    </div>
</div>