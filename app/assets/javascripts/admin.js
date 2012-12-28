
$(function() {

    // Convert select boxes to chosen if they have the chosen class.
    $(".chosen-select").select2();
    $(".chosen-deselect").select2({ allowClear: true });
});