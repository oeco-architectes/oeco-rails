import ready from 'document-ready-promise';

export function addEventListenerOnce(target, name, callback) {
  function boundCallback(...args) {
    callback(...args);
    target.removeEventListener(name, boundCallback);
  }
  target.addEventListener(name, boundCallback);
}

export function setImmediate(fn) {
  return setTimeout(fn, 0);
}

export function onReady(callback) {
  ready().then(() => {
    callback();
    setImmediate(() => document.addEventListener('turbolinks:load', callback));
  });
}
