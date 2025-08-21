<div class="modal fade" id="modalForm" tabindex="-1" aria-labelledby="modalFormLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form>
    <?php echo csrf_input(); ?>
      <div class="modal-header">
        <h5 class="modal-title" id="modalFormLabel">Modal Form (Contextual)</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Contextual fields, adapt per module -->
        <input type="text" class="form-control mb-2" name="field1" placeholder="Field 1">
        <input type="text" class="form-control mb-2" name="field2" placeholder="Field 2">
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary">Submit</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
      </div>
    </form>
  </div>
</div>
