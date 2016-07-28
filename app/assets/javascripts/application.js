// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/ES6 file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require lazyload

import { onReady, addEventListenerOnce } from './dom';
import { carousel } from './carousel';

function updateHtmlAttributes(
  reference = document.body,
  controller = reference.getAttribute('data-controller')
) {
  if (controller) {
    document.documentElement.setAttribute('data-controller', controller);
  }
}

onReady(() => {
  document.documentElement.classList.remove('loading');

  // Carousel
  const element = document.querySelector('.carousel');
  if (element) {
    const { play, dispose } = carousel(element);
    addEventListenerOnce(document, 'turbolinks:before-visit', dispose);
    play(5000);
  }
});

document.addEventListener('turbolinks:click', ({ target }) => {
  document.documentElement.classList.add('loading');
  addEventListenerOnce(document, 'turbolinks:load', () => {
    setTimeout(() => updateHtmlAttributes(target), 0);
  });
});
