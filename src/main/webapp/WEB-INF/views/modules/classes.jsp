<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="card shadow-sm mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold text-primary">Classrooms</h6>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal"
                        data-bs-target="#addClassModal">
                        <i class="fas fa-plus"></i> Add Class
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
                    <table class="table table-bordered table-hover" id="classesTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Level</th>
                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                    <th>Actions</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cls" items="${classes}">
                                <tr>
                                    <td>${cls.id}</td>
                                    <td>${cls.name}</td>
                                    <td>${cls.level}</td>
                                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                        <td>
                                            <button class="btn btn-warning btn-sm edit-btn" data-id="${cls.id}"
                                                data-name="${cls.name}" data-level="${cls.level}" data-bs-toggle="modal"
                                                data-bs-target="#editClassModal">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <a href="${pageContext.request.contextPath}/classes?action=delete&id=${cls.id}"
                                                class="btn btn-danger btn-sm"
                                                onclick="return confirm('Are you sure you want to delete this class?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty classes}">
                                <tr>
                                    <td colspan="4" class="text-center">No classes found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add Class Modal -->
        <div class="modal fade" id="addClassModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Class</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/classes" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required maxlength="30">
                            </div>
                            <div class="mb-3">
                                <label for="level" class="form-label">Level</label>
                                <input type="text" class="form-control" id="level" name="level" maxlength="30">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Class</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Class Modal -->
        <div class="modal fade" id="editClassModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Class</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/classes" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="edit_id" name="id">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="edit_name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="edit_name" name="name" required
                                    maxlength="30">
                            </div>
                            <div class="mb-3">
                                <label for="edit_level" class="form-label">Level</label>
                                <input type="text" class="form-control" id="edit_level" name="level" maxlength="30">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Update Class</button>
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
                        document.getElementById('edit_name').value = this.getAttribute('data-name');
                        document.getElementById('edit_level').value = this.getAttribute('data-level');
                    });
                });
            });
        </script>