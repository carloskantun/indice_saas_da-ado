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
					<td><button class='btn btn-success btn-complete' data-id='${item.id}'><i class='fas fa-check'></i></button></td>
				</tr>`;
            });
            $('#mainTable tbody').html(rows);
        });
    }
    loadTable();

    // Button events
    $('#btn-new').click(function () {
        $('#completeModal').modal('show');
    });
    $(document).on('click', '.btn-complete', function () {
        // ...open complete modal logic...
        $('#completeModal').modal('show');
    });
    $('#completeForm').on('submit', function (e) {
        e.preventDefault();
        // ...submit complete service logic...
        $('#completeModal').modal('hide');
        loadTable();
    });
});
