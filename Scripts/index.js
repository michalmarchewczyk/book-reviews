const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
})

var FileUploadPreviewInputIds = FileUploadPreviewInputIds || [];
var FileUploadPreviewPreviewIds = FileUploadPreviewPreviewIds || [];

FileUploadPreview();

function FileUploadPreview() {
    FileUploadPreviewInputIds.forEach((inputId, index) => {
        const previewId = FileUploadPreviewPreviewIds[index];
        const input = document.getElementById(inputId);
        const preview = document.getElementById(previewId);
        input.addEventListener('change', function () {
            const file = input.files[0];
            if (file) {
                preview.src = URL.createObjectURL(file);
            }
        });
    });
}