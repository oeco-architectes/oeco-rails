import ready from 'document-ready-promise';

export function addEventListenerOnce(target, name, callback) {
  function boundCallback(...args) {
    callback(...args);
    target.removeEventListener(name, boundCallback);
  }
  target.addEventListener(name, boundCallback);
}

export function onReady(callback) {
  ready().then(() => {
    callback();
    setTimeout(() => document.addEventListener('turbolinks:load', callback), 0);
  });
}
