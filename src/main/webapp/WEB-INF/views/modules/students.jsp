<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="card shadow-sm mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold text-primary">Students List</h6>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal"
                        data-bs-target="#addStudentModal">
                        <i class="fas fa-plus"></i> Add Student
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
                    <table class="table table-bordered table-hover" id="studentsTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Reg No</th>
                                <th>Full Name</th>
                                <th>Gender</th>
                                <th>DOB</th>
                                <th>Class</th>
                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                    <th>Actions</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${students}">
                                <tr>
                                    <td>${student.id}</td>
                                    <td>${student.regNo}</td>
                                    <td>${student.fullName}</td>
                                    <td>${student.gender}</td>
                                    <td>${student.dob}</td>
                                    <td>${student.classRoom.name}</td>
                                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                        <td>
                                            <button class="btn btn-warning btn-sm edit-btn" data-id="${student.id}"
                                                data-regno="${student.regNo}" data-fullname="${student.fullName}"
                                                data-gender="${student.gender}" data-dob="${student.dob}"
                                                data-classid="${student.classRoom.id}" data-bs-toggle="modal"
                                                data-bs-target="#editStudentModal">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <a href="${pageContext.request.contextPath}/students?action=delete&id=${student.id}"
                                                class="btn btn-danger btn-sm"
                                                onclick="return confirm('Are you sure you want to delete this student?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty students}">
                                <tr>
                                    <td colspan="7" class="text-center">No students found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add Student Modal -->
        <div class="modal fade" id="addStudentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Student</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/students" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="regNo" class="form-label">Reg No</label>
                                <input type="text" class="form-control" id="regNo" name="regNo" required maxlength="30">
                            </div>
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" required
                                    maxlength="120">
                            </div>
                            <div class="mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="M">Male</option>
                                    <option value="F">Female</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="dob" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="dob" name="dob">
                            </div>
                            <div class="mb-3">
                                <label for="classId" class="form-label">Class</label>
                                <select class="form-select" id="classId" name="classId" required>
                                    <c:forEach var="cls" items="${classes}">
                                        <option value="${cls.id}">${cls.name} (${cls.level})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Student</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Student Modal -->
        <div class="modal fade" id="editStudentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Student</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/students" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="edit_id" name="id">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="edit_regNo" class="form-label">Reg No</label>
                                <input type="text" class="form-control" id="edit_regNo" name="regNo" required
                                    maxlength="30">
                            </div>
                            <div class="mb-3">
                                <label for="edit_fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="edit_fullName" name="fullName" required
                                    maxlength="120">
                            </div>
                            <div class="mb-3">
                                <label for="edit_gender" class="form-label">Gender</label>
                                <select class="form-select" id="edit_gender" name="gender" required>
                                    <option value="M">Male</option>
                                    <option value="F">Female</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="edit_dob" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="edit_dob" name="dob">
                            </div>
                            <div class="mb-3">
                                <label for="edit_classId" class="form-label">Class</label>
                                <select class="form-select" id="edit_classId" name="classId" required>
                                    <c:forEach var="cls" items="${classes}">
                                        <option value="${cls.id}">${cls.name} (${cls.level})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Update Student</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var editButtons = document.querySelectorAll('.edit-btn');
                editButtons.forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        document.getElementById('edit_id').value = this.getAttribute('data-id');
                        document.getElementById('edit_regNo').value = this.getAttribute('data-regno');
                        document.getElementById('edit_fullName').value = this.getAttribute('data-fullname');
                        document.getElementById('edit_gender').value = this.getAttribute('data-gender');
                        document.getElementById('edit_dob').value = this.getAttribute('data-dob');
                        document.getElementById('edit_classId').value = this.getAttribute('data-classid');
                    });
                });
            });
        </script>