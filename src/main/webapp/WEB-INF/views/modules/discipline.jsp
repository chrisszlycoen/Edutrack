<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="card shadow-sm mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold text-primary">Discipline Cases</h6>
                <c:if test="${sessionScope.user.role == 'TEACHER' || sessionScope.user.role == 'ADMIN'}">
                    <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
                        data-bs-target="#addCaseModal">
                        <i class="fas fa-exclamation-circle"></i> Report Case
                    </button>
                </c:if>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success" role="alert">
                        ${message}
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="casesTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Student</th>
                                <th>Class</th>
                                <th>Type</th>
                                <th>Description</th>
                                <th>Action Taken</th>
                                <th>Reported By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dCase" items="${disciplineCases}">
                                <tr>
                                    <td>${dCase.caseDate}</td>
                                    <td>${dCase.student.fullName} (${dCase.student.regNo})</td>
                                    <td>${dCase.student.classRoom.name}</td>
                                    <td><span class="badge bg-danger">${dCase.caseType}</span></td>
                                    <td>${dCase.description}</td>
                                    <td>${dCase.actionTaken}</td>
                                    <td>${dCase.teacher.name}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty disciplineCases}">
                                <tr>
                                    <td colspan="7" class="text-center">No discipline cases found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add Case Modal -->
        <div class="modal fade" id="addCaseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Report Discipline Case</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/discipline" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="studentId" class="form-label">Student</label>
                                <select class="form-select" id="studentId" name="studentId" required>
                                    <option value="">Select Student...</option>
                                    <c:forEach var="student" items="${allStudents}">
                                        <option value="${student.id}">${student.fullName} (${student.regNo})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="caseType" class="form-label">Type</label>
                                <select class="form-select" id="caseType" name="caseType" required>
                                    <option value="Minor Misconduct">Minor Misconduct</option>
                                    <option value="Lateness">Lateness</option>
                                    <option value="Bullying">Bullying</option>
                                    <option value="Cheating">Cheating</option>
                                    <option value="Damage to Property">Damage to Property</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="caseDate" class="form-label">Date</label>
                                <input type="date" class="form-control" id="caseDate" name="caseDate" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"
                                    required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="actionTaken" class="form-label">Action Taken</label>
                                <input type="text" class="form-control" id="actionTaken" name="actionTaken"
                                    maxlength="200">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-danger">Report Case</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>