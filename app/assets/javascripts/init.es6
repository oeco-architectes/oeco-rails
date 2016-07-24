function updateHtmlAttributes(
  reference = document.body,
  controller = reference.getAttribute('data-controller')
) {
  if (controller) {
    document.documentElement.setAttribute('data-controller', controller);
  }
}

$(document).on('ready turbolinks:load', () => {
  $(document).foundation();
  document.documentElement.classList.remove('loading');
});

$(document).on('turbolinks:click', event => {
  document.documentElement.classList.add('loading');

  $(document).one('turbolinks:load', () => {
    updateHtmlAttributes(event.target);
  });
});
