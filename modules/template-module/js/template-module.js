$(function () {
    // Load table data
    function loadTable() {
        $.get('controller.php', { action: 'list' }, function (res) {
            let rows = '';
            (res.data || []).forEach(function (item) {
                rows += `<tr>
                    <td><button class='btn btn-info btn-view' data-id='${item.id}'><i class='fas fa-eye'></i></button></td>
                    <td><button class='btn btn-warning btn-edit' data-id='${item.id}'><i class='fas fa-edit'></i></button></td>
                    <td><button class='btn btn-danger btn-delete' data-id='${item.id}'><i class='fas fa-trash'></i></button></td>
                    <td><button class='btn btn-success btn-action' data-id='${item.id}'><i class='fas fa-bolt'></i></button></td>
                </tr>`;
            });
            $('#mainTable tbody').html(rows);
        });
    }
    loadTable();

    // Button events
    $('#btn-new').click(function () {
        $('#modalForm').modal('show');
    });
    $(document).on('click', '.btn-view', function () {
        // ...view logic...
    });
    $(document).on('click', '.btn-edit', function () {
        // ...edit logic...
    });
    $(document).on('click', '.btn-delete', function () {
        // ...delete logic...
    });
    $(document).on('click', '.btn-action', function () {
        // ...contextual action logic...
        $('#modalForm').modal('show');
    });
    $('#modalForm').on('submit', function (e) {
        e.preventDefault();
        // ...submit logic...
        $('#modalForm').modal('hide');
        loadTable();
    });
});
