export function addEventListenerOnce(target, name, callback) {
  function boundCallback(...args) {
    callback(...args);
    target.removeEventListener(name, boundCallback);
  }
  target.addEventListener(name, boundCallback);
}

export function onReady(callback) {
  document.addEventListener('turbolinks:load', callback);
}
