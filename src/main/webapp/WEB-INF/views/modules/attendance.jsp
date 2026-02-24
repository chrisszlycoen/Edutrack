<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="row">
            <!-- Filter/Search Section -->
            <div class="col-12 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Attendance Management</h6>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/attendance" method="get"
                            class="row g-3 align-items-end">
                            <div class="col-md-4">
                                <label for="filterClass" class="form-label">Class</label>
                                <select class="form-select" id="filterClass" name="classId" required>
                                    <option value="">Select Class...</option>
                                    <c:forEach var="cls" items="${classes}">
                                        <option value="${cls.id}" ${cls.id==selectedClassId ? 'selected' : '' }>
                                            ${cls.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="filterDate" class="form-label">Date</label>
                                <input type="date" class="form-control" id="filterDate" name="date"
                                    value="${selectedDate}" required>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search"></i> Load Students
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty students}">
            <div class="card shadow-sm mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-success">Mark Attendance for ${selectedDate}</h6>
                </div>
                <div class="card-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success" role="alert">
                            ${message}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/attendance" method="post">
                        <input type="hidden" name="action" value="save">
                        <input type="hidden" name="classId" value="${selectedClassId}">
                        <input type="hidden" name="date" value="${selectedDate}">

                        <div class="table-responsive">
                            <table class="table table-bordered table-sm table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>Reg No</th>
                                        <th>Student Name</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="student" items="${students}">
                                        <tr>
                                            <td>${student.regNo}</td>
                                            <td>${student.fullName}</td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <input type="radio" class="btn-check" name="status_${student.id}"
                                                        id="present_${student.id}" value="PRESENT"
                                                        ${existingAttendance[student.id]=='PRESENT' ||
                                                        existingAttendance[student.id]==null ? 'checked' : '' }>
                                                    <label class="btn btn-outline-success btn-sm"
                                                        for="present_${student.id}">Present</label>

                                                    <input type="radio" class="btn-check" name="status_${student.id}"
                                                        id="absent_${student.id}" value="ABSENT"
                                                        ${existingAttendance[student.id]=='ABSENT' ? 'checked' : '' }>
                                                    <label class="btn btn-outline-danger btn-sm"
                                                        for="absent_${student.id}">Absent</label>

                                                    <input type="radio" class="btn-check" name="status_${student.id}"
                                                        id="late_${student.id}" value="LATE"
                                                        ${existingAttendance[student.id]=='LATE' ? 'checked' : '' }>
                                                    <label class="btn btn-outline-warning btn-sm"
                                                        for="late_${student.id}">Late</label>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> Save Attendance
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <c:if test="${empty students and selectedClassId != null}">
            <div class="alert alert-info">No students found for attendance marking in this class.</div>
        </c:if>