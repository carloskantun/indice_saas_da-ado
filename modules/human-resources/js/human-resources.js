/**
 * MÓDULO RECURSOS HUMANOS - JavaScript
 * Sistema SaaS Indice - Versión Expandida con Gestión de Permisos
 */

// Variables globales
let currentEmployeeId = null;
let isEditing = false;
let existingUser = null;
let availableModules = [];

// Configuración de DataTables y Select2
$(document).ready(function () {
    // Inicializar Select2
    $('.select2').select2({
        placeholder: 'Seleccionar...',
        allowClear: true,
        language: 'es'
    });

    // Inicializar tooltips
    $('[data-bs-toggle="tooltip"]').tooltip();

    // Event listeners
    initEventListeners();

    // Cargar datos iniciales
    loadDepartments();
    loadPositions();
    loadAvailableModules();
});

// ============================================================================
// EVENT LISTENERS
// ============================================================================

function initEventListeners() {
    // Crear nuevo puesto desde el modal de departamentos
    $('#formNewPosition').on('submit', function (e) {
        e.preventDefault();
        const positionName = $('#positionName').val().trim();
        if (!positionName) return;
        // Aquí normalmente harías una petición AJAX para guardar el puesto en el backend
        // Por ahora solo mostramos mensaje de éxito y limpiamos el campo
        $('#positionSuccessMsg').removeClass('d-none');
        setTimeout(() => {
            $('#positionSuccessMsg').addClass('d-none');
        }, 2000);
        $('#positionName').val('');
    });

    // Nuevo empleado
    $('#btnNewEmployee').on('click', function () {
        openEmployeeModal();
    });

    // Verificación de usuario existente cuando se cambia el email
    $('#email').on('blur', function () {
        const email = $(this).val();
        if (email && isValidEmail(email)) {
            checkExistingUser(email);
        }
    });

    // Cambio en templates de roles
    $('input[name="role_template"]').on('change', function () {
        const selectedRole = $(this).val();
        applyRoleTemplate(selectedRole);
    });

    // Toggle de módulos
    $(document).on('change', 'input[name="modules[]"]', function () {
        const moduleSlug = $(this).val();
        const permissionsDiv = $('#permissions_' + moduleSlug.replace('-', '_'));

        if ($(this).is(':checked')) {
            permissionsDiv.removeClass('d-none');
            loadModulePermissions(moduleSlug);
        } else {
            permissionsDiv.addClass('d-none');
            permissionsDiv.find('input[type="checkbox"]').prop('checked', false);
        }
    });

    // Toggle para crear cuenta de usuario
    $('#create_user_account').on('change', function () {
        const invitationSection = $('#invitation_preview');
        if ($(this).is(':checked')) {
            invitationSection.show();
            $('#auto_send_invitation').closest('.col-md-6').show();
        } else {
            invitationSection.hide();
            $('#auto_send_invitation').closest('.col-md-6').hide();
        }
    });

    // Cambios en role templates
    $('.role-template').on('click', function () {
        const roleInput = $(this).find('input[type="radio"]');
        roleInput.prop('checked', true);
        $('.role-template').removeClass('border-primary');
        $(this).addClass('border-primary');
        applyRoleTemplate(roleInput.val());
    });

    // Editar empleado
    $(document).on('click', '.edit-employee', function () {
        const employeeId = $(this).data('employee-id');
        editEmployee(employeeId);
    });

    // Ver empleado
    $(document).on('click', '.view-employee', function () {
        const employeeId = $(this).data('employee-id');
        viewEmployee(employeeId);
    });

    // Eliminar empleado
    $(document).on('click', '.delete-employee', function () {
        const employeeId = $(this).data('employee-id');
        const employeeName = $(this).data('employee-name');
        deleteEmployee(employeeId, employeeName);
    });

    // Formulario de empleado
    $('#employeeForm').on('submit', function (e) {
        e.preventDefault();
        saveEmployee();
    });

    // KPIs
    $('#btnKPIs').on('click', function () {
        loadKPIs();
    });

    // Filtros dinámicos
    $('select[name="department_id"]').on('change', function () {
        const departmentId = $(this).val();
        loadPositionsByDepartment(departmentId);
    });

    // Departamentos
    $('#btnDepartments').on('click', function () {
        openDepartmentModal();
    });

    // Posiciones
    $('#btnPositions').on('click', function () {
        openPositionModal();
    });

    // Toggle de columnas
    $('.col-toggle').on('change', function () {
        const column = $(this).data('col');
        const isVisible = $(this).is(':checked');
        toggleColumn(column, isVisible);
    });
}

// ============================================================================
// FUNCIONES PARA EMPLEADOS
// ============================================================================

function openEmployeeModal(employee = null) {
    isEditing = employee !== null;
    currentEmployeeId = employee ? employee.id : null;

    // Resetear formulario
    $('#employeeForm')[0].reset();

    // Configurar modal
    const modalTitle = isEditing ? 'Editar Empleado' : 'Nuevo Empleado';
    $('#employeeModal .modal-title').text(modalTitle);

    if (isEditing && employee) {
        // Llenar formulario con datos del empleado
        fillEmployeeForm(employee);
    }

    // Mostrar modal
    $('#employeeModal').modal('show');
}

function fillEmployeeForm(employee) {
    $('#employee_number').val(employee.employee_number);
    $('#first_name').val(employee.first_name);
    $('#last_name').val(employee.last_name);
    $('#email').val(employee.email);
    $('#phone').val(employee.phone);
    $('#department_id').val(employee.department_id).trigger('change');
    $('#position_id').val(employee.position_id).trigger('change');
    $('#hire_date').val(employee.hire_date);
    $('#employment_type').val(employee.employment_type);
    $('#contract_type').val(employee.contract_type);
    $('#salary').val(employee.salary);
    $('#payment_frequency').val(employee.payment_frequency);
    $('#status').val(employee.status);
}

function saveEmployee() {
    const formData = new FormData($('#employeeForm')[0]);
    const action = isEditing ? 'edit_employee' : 'create_employee_with_invitation';

    formData.append('action', action);
    if (isEditing) {
        formData.append('employee_id', currentEmployeeId);
    }

    // Mostrar loading
    showLoading('#employeeModal .modal-body');

    $.ajax({
        url: 'controller.php',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
            hideLoading('#employeeModal .modal-body');

            if (response.success) {
                showAlert('success', response.message);
                $('#employeeModal').modal('hide');
                location.reload(); // Recargar página para mostrar cambios
            } else {
                showAlert('danger', response.error || 'Error al guardar empleado');
            }
        },
        error: function () {
            hideLoading('#employeeModal .modal-body');
            showAlert('danger', 'Error de comunicación con el servidor');
        }
    });
}

function editEmployee(employeeId) {
    $.ajax({
        url: 'controller.php',
        type: 'GET',
        data: {
            action: 'get_employee',
            employee_id: employeeId
        },
        success: function (response) {
            if (response.success) {
                openEmployeeModal(response.employee);
            } else {
                showAlert('danger', response.error || 'Error al cargar empleado');
            }
        },
        error: function () {
            showAlert('danger', 'Error de comunicación con el servidor');
        }
    });
}

function viewEmployee(employeeId) {
    $.ajax({
        url: 'controller.php',
        type: 'GET',
        data: {
            action: 'get_employee',
            employee_id: employeeId
        },
        success: function (response) {
            if (response.success) {
                showEmployeeDetails(response.employee);
            } else {
                showAlert('danger', response.error || 'Error al cargar empleado');
            }
        },
        error: function () {
            showAlert('danger', 'Error de comunicación con el servidor');
        }
    });
}

function showEmployeeDetails(employee) {
    const modalHtml = `
        <div class="modal fade" id="employeeDetailsModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">
                            <i class="fas fa-user me-2"></i>Detalles del Empleado
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr><th>Número:</th><td>${employee.employee_number || 'N/A'}</td></tr>
                                    <tr><th>Nombre:</th><td>${employee.first_name} ${employee.last_name}</td></tr>
                                    <tr><th>Email:</th><td>${employee.email || 'N/A'}</td></tr>
                                    <tr><th>Teléfono:</th><td>${employee.phone || 'N/A'}</td></tr>
                                    <tr><th>Fecha Ingreso:</th><td>${employee.hire_date || 'N/A'}</td></tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr><th>Departamento:</th><td>${employee.department_name || 'Sin asignar'}</td></tr>
                                    <tr><th>Posición:</th><td>${employee.position_title || 'Sin asignar'}</td></tr>
                                    <tr><th>Tipo Empleo:</th><td>${employee.employment_type}</td></tr>
                                    <tr><th>Tipo Contrato:</th><td>${employee.contract_type}</td></tr>
                                    <tr><th>Salario:</th><td>$${parseFloat(employee.salary).toLocaleString()}</td></tr>
                                    <tr><th>Frecuencia Pago:</th><td>${employee.payment_frequency}</td></tr>
                                    <tr><th>Estatus:</th><td><span class="badge bg-${getStatusColor(employee.status)}">${employee.status}</span></td></tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    `;

    // Remover modal anterior si existe
    $('#employeeDetailsModal').remove();

    // Agregar y mostrar nuevo modal
    $('body').append(modalHtml);
    $('#employeeDetailsModal').modal('show');
}

function deleteEmployee(employeeId, employeeName) {
    Swal.fire({
        title: '¿Dar de baja empleado?',
        text: `¿Estás seguro de dar de baja a ${employeeName}?`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#e74c3c',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Sí, dar de baja',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: 'controller.php',
                type: 'POST',
                data: {
                    action: 'delete_employee',
                    employee_id: employeeId
                },
                success: function (response) {
                    if (response.success) {
                        showAlert('success', response.message);
                        location.reload();
                    } else {
                        showAlert('danger', response.error || 'Error al dar de baja empleado');
                    }
                },
                error: function () {
                    showAlert('danger', 'Error de comunicación con el servidor');
                }
            });
        }
    });
}

// ============================================================================
// FUNCIONES PARA DEPARTAMENTOS Y POSICIONES
// ============================================================================

function loadDepartments() {
    $.ajax({
        url: 'controller.php',
        type: 'GET',
        data: { action: 'get_departments' },
        success: function (response) {
            if (response.success) {
                updateDepartmentSelects(response.departments);
            }
        },
        error: function () {
            console.error('Error al cargar departamentos');
        }
    });
}

function loadPositions() {
    $.ajax({
        url: 'controller.php',
        type: 'GET',
        data: { action: 'get_positions' },
        success: function (response) {
            if (response.success) {
                updatePositionSelects(response.positions);
            }
        },
        error: function () {
            console.error('Error al cargar posiciones');
        }
    });
}

function loadPositionsByDepartment(departmentId) {
    if (!departmentId) {
        loadPositions();
        return;
    }

    $.ajax({
        url: 'controller.php',
        type: 'GET',
        data: {
            action: 'get_positions',
            department_id: departmentId
        },
        success: function (response) {
            if (response.success) {
                updatePositionSelects(response.positions, '#position_id');
            }
        },
        error: function () {
            console.error('Error al cargar posiciones por departamento');
        }
    });
}

function updateDepartmentSelects(departments) {
    const selects = $('select[name="department_id"], #department_id');

    selects.each(function () {
        const currentValue = $(this).val();
        const isFilter = $(this).attr('name') === 'department_id';

        $(this).empty();

        if (isFilter) {
            $(this).append('<option value="">Todos los departamentos</option>');
        } else {
            $(this).append('<option value="">Seleccionar departamento</option>');
        }

        departments.forEach(dept => {
            const selected = currentValue == dept.id ? 'selected' : '';
            $(this).append(`<option value="${dept.id}" ${selected}>${dept.name}</option>`);
        });

        $(this).trigger('change');
    });
}

function updatePositionSelects(positions, selector = 'select[name="position_id"], #position_id') {
    const selects = $(selector);

    selects.each(function () {
        const currentValue = $(this).val();
        const isFilter = $(this).attr('name') === 'position_id';

        $(this).empty();

        if (isFilter) {
            $(this).append('<option value="">Todas las posiciones</option>');
        } else {
            $(this).append('<option value="">Seleccionar posición</option>');
        }

        positions.forEach(pos => {
            const selected = currentValue == pos.id ? 'selected' : '';
            $(this).append(`<option value="${pos.id}" ${selected}>${pos.title}</option>`);
        });

        $(this).trigger('change');
    });
}

function openDepartmentModal() {
    // TODO: Implementar modal de gestión de departamentos
    showAlert('info', 'Gestión de departamentos en desarrollo');
}

function openPositionModal() {
    // TODO: Implementar modal de gestión de posiciones
    showAlert('info', 'Gestión de posiciones en desarrollo');
}

// ============================================================================
// FUNCIONES PARA KPIs
// ============================================================================

function loadKPIs() {
    showLoading('#kpisModal .modal-body');

    $.ajax({
        url: 'controller.php',
        type: 'GET',
        data: { action: 'get_kpis' },
        success: function (response) {
            hideLoading('#kpisModal .modal-body');

            if (response.success) {
                renderKPIs(response.kpis);
            } else {
                showAlert('danger', response.error || 'Error al cargar KPIs');
            }
        },
        error: function () {
            hideLoading('#kpisModal .modal-body');
            showAlert('danger', 'Error de comunicación con el servidor');
        }
    });
}

function renderKPIs(kpis) {
    const kpisHtml = `
        <div class="row">
            <div class="col-md-6 mb-3">
                <div class="card kpi-card primary">
                    <div class="kpi-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="kpi-value">${kpis.total_employees}</div>
                    <div class="kpi-label">Empleados Activos</div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card kpi-card success">
                    <div class="kpi-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="kpi-value">${kpis.new_employees_month}</div>
                    <div class="kpi-label">Nuevos este Mes</div>
                </div>
            </div>
            <div class="col-md-12 mb-3">
                <div class="card kpi-card warning">
                    <div class="kpi-icon">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="kpi-value">$${parseFloat(kpis.total_payroll).toLocaleString()}</div>
                    <div class="kpi-label">Nómina Mensual Total</div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <h6><i class="fas fa-building me-2"></i>Por Departamento</h6>
                <div class="list-group">
                    ${kpis.department_distribution.map(dept => `
                        <div class="list-group-item d-flex justify-content-between align-items-center">
                            ${dept.name || 'Sin asignar'}
                            <span class="badge bg-primary rounded-pill">${dept.count}</span>
                        </div>
                    `).join('')}
                </div>
            </div>
            <div class="col-md-6">
                <h6><i class="fas fa-chart-pie me-2"></i>Por Estatus</h6>
                <div class="list-group">
                    ${kpis.status_distribution.map(status => `
                        <div class="list-group-item d-flex justify-content-between align-items-center">
                            ${status.status}
                            <span class="badge bg-${getStatusColor(status.status)} rounded-pill">${status.count}</span>
                        </div>
                    `).join('')}
                </div>
            </div>
        </div>
    `;

    $('#kpisContent').html(kpisHtml);
}

// ============================================================================
// FUNCIONES AUXILIARES
// ============================================================================

function getStatusColor(status) {
    const colors = {
        'Activo': 'success',
        'Inactivo': 'secondary',
        'Vacaciones': 'warning',
        'Licencia': 'info',
        'Baja': 'danger'
    };
    return colors[status] || 'secondary';
}

function showAlert(type, message) {
    const alertHtml = `
        <div class="alert alert-${type} alert-dismissible fade show alert-hr" role="alert">
            <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-triangle' : 'info-circle'} me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `;

    $('#alertContainer').prepend(alertHtml);

    // Auto-hide después de 5 segundos
    setTimeout(() => {
        $('#alertContainer .alert:first-child').fadeOut(() => {
            $(this).remove();
        });
    }, 5000);
}

function showLoading(container) {
    $(container).addClass('loading');
    $(container).append('<div class="text-center loading-spinner"><div class="spinner-border" role="status"></div></div>');
}

function hideLoading(container) {
    $(container).removeClass('loading');
    $(container).find('.loading-spinner').remove();
}

// Función para formatear números
function formatNumber(number, decimals = 2) {
    return parseFloat(number).toLocaleString('es-MX', {
        minimumFractionDigits: decimals,
        maximumFractionDigits: decimals
    });
}

// ============================================================================
// NUEVAS FUNCIONES PARA GESTIÓN DE PERMISOS E INVITACIONES
// ============================================================================

/**
 * Verificar si un usuario ya existe en el sistema
 */
function checkExistingUser(email) {
    if (!email || !isValidEmail(email)) return;

    $.ajax({
        url: 'includes/invitation_system.php',
        method: 'POST',
        data: {
            action: 'check_user',
            email: email
        },
        dataType: 'json',
        success: function (response) {
            if (response.exists) {
                showExistingUserAlert(response.user);
                preloadUserData(response.user);
                existingUser = response.user;
            } else {
                hideExistingUserAlert();
                existingUser = null;
            }
        },
        error: function () {
            console.error('Error al verificar usuario existente');
        }
    });
}

/**
 * Mostrar alerta de usuario existente
 */
function showExistingUserAlert(user) {
    const companiesText = user.companies.length > 0
        ? `Participa en ${user.companies.length} empresa(s)`
        : 'Sin empresas asignadas';

    $('#user_detection_alert').removeClass('d-none');
    $('#existing_user_info').html(`
        <strong>${user.first_name} ${user.last_name}</strong> (${user.email})
        <br><small>${companiesText}</small>
    `);

    $('#user_status_info').html(`
        <i class="fas fa-user-check me-1"></i>
        Se asignará a la empresa actual. No se enviará invitación.
    `);

    $('#send_invitation').prop('checked', false);
}

/**
 * Ocultar alerta de usuario existente
 */
function hideExistingUserAlert() {
    $('#user_detection_alert').addClass('d-none');
    $('#user_status_info').html(`
        <i class="fas fa-envelope me-1"></i>
        Se enviará una invitación para registrarse en el sistema
    `);
    $('#send_invitation').prop('checked', true);
}

/**
 * Precargar datos de usuario existente
 */
function preloadUserData(user) {
    $('#first_name').val(user.first_name);
    $('#last_name').val(user.last_name);
    $('#phone').val(user.phone || '');
    $('#fiscal_id').val(user.fiscal_id || '');

    // Deshabilitar campos que ya existen
    $('#first_name, #last_name, #email').prop('readonly', true);
}

/**
 * Cargar módulos disponibles para asignación
 */
function loadAvailableModules() {
    $.ajax({
        url: 'includes/invitation_system.php',
        method: 'POST',
        data: {
            action: 'get_modules'
        },
        dataType: 'json',
        success: function (response) {
            if (response.modules) {
                availableModules = response.modules;
                renderModulesAssignment(response.modules);
            }
        },
        error: function () {
            console.error('Error al cargar módulos disponibles');
        }
    });
}

/**
 * Renderizar módulos para asignación
 */
function renderModulesAssignment(modules) {
    const container = $('#modules_assignment');
    let html = '';

    modules.forEach(module => {
        const moduleKey = module.slug.replace('-', '_');
        html += `
            <div class="col-md-6">
                <div class="card border-light">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <i class="${module.icon} fa-2x me-3" style="color: ${module.color}"></i>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">${module.name}</h6>
                                <small class="text-muted">${module.description}</small>
                            </div>
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" 
                                       id="module_${moduleKey}" name="modules[]" value="${module.slug}">
                            </div>
                        </div>
                        <!-- Permisos específicos -->
                        <div class="module-permissions mt-2 d-none" id="permissions_${moduleKey}">
                            <small class="text-muted">Permisos específicos:</small>
                            <div class="permissions-list">
                                <!-- Se cargarán dinámicamente -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    });

    container.html(html);
}

/**
 * Cargar permisos específicos de un módulo
 */
function loadModulePermissions(moduleSlug) {
    $.ajax({
        url: 'includes/invitation_system.php',
        method: 'POST',
        data: {
            action: 'get_module_permissions',
            module_slug: moduleSlug
        },
        dataType: 'json',
        success: function (response) {
            if (response.permissions) {
                renderModulePermissions(moduleSlug, response.permissions);
            }
        },
        error: function () {
            console.error('Error al cargar permisos del módulo');
        }
    });
}

/**
 * Renderizar permisos específicos de un módulo
 */
function renderModulePermissions(moduleSlug, permissions) {
    const moduleKey = moduleSlug.replace('-', '_');
    const container = $(`#permissions_${moduleKey} .permissions-list`);

    let html = '';
    permissions.forEach(permission => {
        const permId = `perm_${moduleKey}_${permission.permission_key.replace('.', '_')}`;
        html += `
            <div class="form-check form-check-sm">
                <input class="form-check-input" type="checkbox" 
                       id="${permId}" name="permissions[]" value="${permission.permission_key}">
                <label class="form-check-label small" for="${permId}">
                    ${permission.description}
                </label>
            </div>
        `;
    });

    container.html(html);
}

/**
 * Aplicar plantilla de rol
 */
function applyRoleTemplate(role) {
    // Limpiar selecciones actuales
    $('input[name="modules[]"]').prop('checked', false);
    $('input[name="permissions[]"]').prop('checked', false);
    $('.module-permissions').addClass('d-none');

    // Configuraciones por rol
    const roleConfigs = {
        admin: {
            modules: ['human-resources', 'expenses'],
            autoPermissions: true,
            description: 'Acceso completo a módulos principales'
        },
        moderator: {
            modules: ['human-resources'],
            permissions: ['employees.view', 'employees.edit', 'departments.view'],
            description: 'Supervisión limitada de recursos humanos'
        },
        user: {
            modules: [],
            permissions: ['employees.view'],
            description: 'Acceso básico de solo lectura'
        }
    };

    const config = roleConfigs[role];
    if (!config) return;

    // Aplicar módulos
    config.modules.forEach(moduleSlug => {
        const moduleKey = moduleSlug.replace('-', '_');
        $(`#module_${moduleKey}`).prop('checked', true).trigger('change');

        if (config.autoPermissions) {
            // Para admin, seleccionar todos los permisos automáticamente
            setTimeout(() => {
                $(`#permissions_${moduleKey} input[type="checkbox"]`).prop('checked', true);
            }, 500);
        }
    });

    // Aplicar permisos específicos
    if (config.permissions) {
        config.permissions.forEach(permission => {
            $(`input[value="${permission}"]`).prop('checked', true);
        });
    }

    showAlert('info', `Plantilla aplicada: ${config.description}`);
}

/**
 * Validar email
 */
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

/**
 * Limpiar modal de empleado
 */
function clearEmployeeModal() {
    $('#employeeForm')[0].reset();
    $('#first_name, #last_name, #email').prop('readonly', false);
    hideExistingUserAlert();
    existingUser = null;

    // Limpiar tabs
    $('#personal-tab').tab('show');
    $('input[name="modules[]"]').prop('checked', false);
    $('input[name="permissions[]"]').prop('checked', false);
    $('.module-permissions').addClass('d-none');
    $('input[name="role_template"][value="user"]').prop('checked', true);
    $('.role-template').removeClass('border-primary');
    $('.role-template[data-role="user"]').addClass('border-primary');
}

/**
 * Expandir función openEmployeeModal existente
 */
function openEmployeeModal(employeeId = null) {
    currentEmployeeId = employeeId;
    isEditing = employeeId !== null;

    // Limpiar modal
    clearEmployeeModal();

    // Configurar título
    const title = isEditing ? 'Editar Empleado' : 'Nuevo Empleado';
    $('#employeeModal .modal-title').html(`<i class="fas fa-user-${isEditing ? 'edit' : 'plus'} me-2"></i>${title}`);

    // Si es edición, cargar datos
    if (isEditing) {
        loadEmployeeData(employeeId);
    }

    // Mostrar modal
    $('#employeeModal').modal('show');
}

// ============================================================================
// FUNCIONES PARA PASE DE LISTA / ASISTENCIA
// ============================================================================

/**
 * Inicializar modal de asistencia
 */
function initAttendanceModal() {
    // Cargar departamentos en el filtro
    loadDepartmentsForAttendance();

    // Cargar asistencia del día actual
    loadAttendanceData();

    // Event listeners
    $('#loadAttendance').on('click', function () {
        loadAttendanceData();
    });

    $('#saveAllAttendance').on('click', function () {
        saveAllAttendance();
    });

    $('#exportAttendance').on('click', function () {
        exportAttendanceData();
    });

    // Cambios en filtros
    $('#attendance_date, #attendance_department, #attendance_status').on('change', function () {
        loadAttendanceData();
    });
}

/**
 * Cargar departamentos para el filtro de asistencia
 */
function loadDepartmentsForAttendance() {
    $.ajax({
        url: 'controller.php',
        type: 'GET',
        data: { action: 'get_departments' },
        success: function (response) {
            if (response.success) {
                const select = $('#attendance_department');
                select.empty().append('<option value="">Todos los departamentos</option>');

                response.departments.forEach(function (dept) {
                    select.append(`<option value="${dept.id}">${dept.name}</option>`);
                });
            }
        },
        error: function () {
            showAlert('danger', 'Error al cargar departamentos');
        }
    });
}

/**
 * Cargar datos de asistencia
 */
function loadAttendanceData() {
    const date = $('#attendance_date').val();
    const departmentId = $('#attendance_department').val();
    const status = $('#attendance_status').val();

    showLoading('#attendanceTableBody');

    $.ajax({
        url: 'controller.php',
        type: 'GET',
        data: {
            action: 'get_attendance',
            date: date,
            department_id: departmentId,
            status: status
        },
        success: function (response) {
            hideLoading('#attendanceTableBody');

            if (response.success) {
                renderAttendanceTable(response.data);
                updateAttendanceSummary(response.summary);
            } else {
                showAlert('danger', response.error || 'Error al cargar asistencia');
            }
        },
        error: function () {
            hideLoading('#attendanceTableBody');
            showAlert('danger', 'Error de comunicación con el servidor');
        }
    });
}

/**
 * Renderizar tabla de asistencia
 */
function renderAttendanceTable(employees) {
    const tbody = $('#attendanceTableBody');
    tbody.empty();

    if (employees.length === 0) {
        tbody.append(`
            <tr>
                <td colspan="7" class="text-center text-muted py-4">
                    <i class="fas fa-info-circle me-2"></i>No hay empleados para mostrar
                </td>
            </tr>
        `);
        return;
    }

    employees.forEach(function (employee) {
        const statusClass = getStatusClass(employee.status);
        const statusText = getStatusText(employee.status);

        const row = `
            <tr data-employee-id="${employee.employee_id}">
                <td>
                    <div class="d-flex align-items-center">
                        <div class="status-indicator bg-${statusClass} me-2"></div>
                        <div>
                            <strong>${employee.full_name}</strong><br>
                            <small class="text-muted">${employee.employee_number}</small>
                        </div>
                    </div>
                </td>
                <td>${employee.department_name || 'Sin departamento'}</td>
                <td>${employee.position_title || 'Sin posición'}</td>
                <td>
                    <input type="time" class="form-control form-control-sm check-in-time" 
                           value="${employee.check_in_time || ''}" 
                           ${employee.status === 'ausente' ? 'disabled' : ''}>
                </td>
                <td>
                    <select class="form-select form-select-sm attendance-status">
                        <option value="presente" ${employee.status === 'presente' ? 'selected' : ''}>Presente</option>
                        <option value="ausente" ${employee.status === 'ausente' ? 'selected' : ''}>Ausente</option>
                        <option value="tardanza" ${employee.status === 'tardanza' ? 'selected' : ''}>Tardanza</option>
                        <option value="permiso" ${employee.status === 'permiso' ? 'selected' : ''}>Con Permiso</option>
                        <option value="vacaciones" ${employee.status === 'vacaciones' ? 'selected' : ''}>Vacaciones</option>
                        <option value="incapacidad" ${employee.status === 'incapacidad' ? 'selected' : ''}>Incapacidad</option>
                    </select>
                </td>
                <td>
                    <input type="text" class="form-control form-control-sm attendance-notes" 
                           placeholder="Notas opcionales..." 
                           value="${employee.notes || ''}">
                </td>
                <td>
                    <button type="button" class="btn btn-sm btn-success save-attendance" 
                            data-employee-id="${employee.employee_id}">
                        <i class="fas fa-save"></i>
                    </button>
                </td>
            </tr>
        `;
        tbody.append(row);
    });

    // Event listeners para cambios en tiempo real
    $('.attendance-status').on('change', function () {
        const status = $(this).val();
        const timeInput = $(this).closest('tr').find('.check-in-time');

        if (status === 'ausente') {
            timeInput.prop('disabled', true).val('');
        } else {
            timeInput.prop('disabled', false);
            if (!timeInput.val() && status === 'presente') {
                timeInput.val('08:00');
            } else if (!timeInput.val() && status === 'tardanza') {
                timeInput.val('09:00');
            }
        }

        updateRowStatus($(this).closest('tr'), status);
    });

    // Event listeners para guardar individual
    $('.save-attendance').on('click', function () {
        const employeeId = $(this).data('employee-id');
        saveIndividualAttendance(employeeId);
    });
}

/**
 * Actualizar resumen de asistencia
 */
function updateAttendanceSummary(summary) {
    $('#present_count').text(summary.presente || 0);
    $('#absent_count').text(summary.ausente || 0);
    $('#late_count').text(summary.tardanza || 0);
    $('#permission_count').text((summary.permiso || 0) + (summary.vacaciones || 0) + (summary.incapacidad || 0));
}

/**
 * Obtener clase CSS para el estado
 */
function getStatusClass(status) {
    const classes = {
        'presente': 'success',
        'ausente': 'danger',
        'tardanza': 'warning',
        'permiso': 'info',
        'vacaciones': 'primary',
        'incapacidad': 'secondary'
    };
    return classes[status] || 'secondary';
}

/**
 * Obtener texto para el estado
 */
function getStatusText(status) {
    const texts = {
        'presente': 'Presente',
        'ausente': 'Ausente',
        'tardanza': 'Tardanza',
        'permiso': 'Con Permiso',
        'vacaciones': 'Vacaciones',
        'incapacidad': 'Incapacidad'
    };
    return texts[status] || status;
}

/**
 * Actualizar estado visual de la fila
 */
function updateRowStatus(row, status) {
    const indicator = row.find('.status-indicator');
    const statusClass = getStatusClass(status);

    indicator.removeClass('bg-success bg-danger bg-warning bg-info bg-primary bg-secondary')
        .addClass(`bg-${statusClass}`);
}

/**
 * Guardar asistencia individual
 */
function saveIndividualAttendance(employeeId) {
    const row = $(`tr[data-employee-id="${employeeId}"]`);
    const data = {
        action: 'save_attendance',
        employee_id: employeeId,
        date: $('#attendance_date').val(),
        status: row.find('.attendance-status').val(),
        check_in_time: row.find('.check-in-time').val(),
        notes: row.find('.attendance-notes').val()
    };

    $.ajax({
        url: 'controller.php',
        type: 'POST',
        data: data,
        success: function (response) {
            if (response.success) {
                showAlert('success', 'Asistencia guardada correctamente');
                // Actualizar indicador visual
                const saveBtn = row.find('.save-attendance');
                saveBtn.removeClass('btn-success').addClass('btn-outline-success');
                setTimeout(() => {
                    saveBtn.removeClass('btn-outline-success').addClass('btn-success');
                }, 1000);
            } else {
                showAlert('danger', response.error || 'Error al guardar asistencia');
            }
        },
        error: function () {
            showAlert('danger', 'Error de comunicación con el servidor');
        }
    });
}

/**
 * Guardar toda la asistencia
 */
function saveAllAttendance() {
    const attendanceData = [];
    const date = $('#attendance_date').val();

    $('#attendanceTableBody tr[data-employee-id]').each(function () {
        const row = $(this);
        attendanceData.push({
            employee_id: row.data('employee-id'),
            status: row.find('.attendance-status').val(),
            check_in_time: row.find('.check-in-time').val(),
            notes: row.find('.attendance-notes').val()
        });
    });

    if (attendanceData.length === 0) {
        showAlert('warning', 'No hay datos de asistencia para guardar');
        return;
    }

    showLoading('#saveAllAttendance');

    $.ajax({
        url: 'controller.php',
        type: 'POST',
        data: {
            action: 'save_all_attendance',
            date: date,
            attendance_data: JSON.stringify(attendanceData)
        },
        success: function (response) {
            hideLoading('#saveAllAttendance');

            if (response.success) {
                showAlert('success', `Asistencia guardada para ${response.saved_count} empleados`);
                loadAttendanceData(); // Recargar datos
            } else {
                showAlert('danger', response.error || 'Error al guardar asistencia');
            }
        },
        error: function () {
            hideLoading('#saveAllAttendance');
            showAlert('danger', 'Error de comunicación con el servidor');
        }
    });
}

/**
 * Exportar datos de asistencia
 */
function exportAttendanceData() {
    const date = $('#attendance_date').val();
    const departmentId = $('#attendance_department').val();

    const params = new URLSearchParams({
        action: 'export_attendance',
        date: date
    });

    if (departmentId) {
        params.append('department_id', departmentId);
    }

    window.open(`controller.php?${params.toString()}`, '_blank');
}

// Inicializar cuando se abra el modal de asistencia
$(document).on('shown.bs.modal', '#attendanceModal', function () {
    initAttendanceModal();
});

// Agregar estilos CSS para el indicador de estado
$('<style>')
    .prop('type', 'text/css')
    .html(`
        .status-indicator {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
        }
        
        .attendance-notes {
            min-width: 150px;
        }
        
        .check-in-time {
            min-width: 100px;
        }
        
        .attendance-status {
            min-width: 120px;
        }
        
        #attendanceTable td {
            vertical-align: middle;
        }
    `)
    .appendTo('head');

// ============================================================================
// FUNCIONES PARA TOGGLE DE COLUMNAS
// ============================================================================

/**
 * Alternar visibilidad de columnas
 */
function toggleColumn(column, isVisible) {
    const selector = `[data-col="${column}"]`;

    if (isVisible) {
        $(selector).show();
    } else {
        $(selector).hide();
    }

    // Guardar preferencias en localStorage
    saveColumnPreferences();
}

/**
 * Guardar preferencias de columnas
 */
function saveColumnPreferences() {
    const preferences = {};
    $('.col-toggle').each(function () {
        const column = $(this).data('col');
        preferences[column] = $(this).is(':checked');
    });

    localStorage.setItem('hr_column_preferences', JSON.stringify(preferences));
}

/**
 * Cargar preferencias de columnas
 */
function loadColumnPreferences() {
    const saved = localStorage.getItem('hr_column_preferences');

    if (saved) {
        try {
            const preferences = JSON.parse(saved);

            $('.col-toggle').each(function () {
                const column = $(this).data('col');
                if (preferences.hasOwnProperty(column)) {
                    $(this).prop('checked', preferences[column]);
                    toggleColumn(column, preferences[column]);
                }
            });
        } catch (e) {
            console.warn('Error loading column preferences:', e);
        }
    }
}

// Cargar preferencias al inicializar
$(document).ready(function () {
    // Pequeño delay para asegurar que todo esté cargado
    setTimeout(loadColumnPreferences, 100);
});
