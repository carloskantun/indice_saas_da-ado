<div class="modal fade" id="completeModal" tabindex="-1" aria-labelledby="completeModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form>
    <?php echo csrf_input(); ?>
      <div class="modal-header">
        <h5 class="modal-title" id="completeModalLabel"><?php echo $lang['complete_service'] ?? 'Complete Service'; ?></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="file" name="service_photos[]" multiple accept="image/*" class="form-control mb-2">
        <textarea name="work_description" class="form-control mb-2" placeholder="<?php echo $lang['work_description'] ?? 'Describe the work performed'; ?>"></textarea>
        <select name="completion_status" class="form-select mb-2">
          <option value="completed"><?php echo $lang['completed'] ?? 'Completed'; ?></option>
          <option value="partial"><?php echo $lang['partial'] ?? 'Partial'; ?></option>
        </select>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-success"><?php echo $lang['submit'] ?? 'Submit'; ?></button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><?php echo $lang['cancel'] ?? 'Cancel'; ?></button>
      </div>
    </form>
  </div>
</div>
