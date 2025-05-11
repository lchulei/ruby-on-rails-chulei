document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('[data-confirm]').forEach((element) => {
    element.addEventListener('click', function (event) {
      const message = element.getAttribute('data-confirm');
      if (!confirm(message)) {
        event.preventDefault();
        event.stopImmediatePropagation();
      }
    });
  });
});
