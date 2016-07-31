import ready from 'document-ready-promise';

export function queryAll(node, selector) {
  return Array.prototype.slice.call(node.querySelectorAll(selector));
}

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

export function isElementInViewport(element) {
  const { innerHeight, innerWidth } = element.ownerDocument.defaultView;
  const { bottom, right, top, left } = element.getBoundingClientRect();
  return bottom >= 0 && right >= 0 && top <= innerHeight && left <= innerWidth;
}

export function setImageSrc(img, src) {
  return new Promise((resolve, reject) => {
    img.onload = () => resolve({ img, src });
    img.onerror = err => reject(err);
    img.src = src;
  });
}

export function isEventSupported(eventName, target = window.document) {
  let isEventSupported = false;
  addEventListenerOnce(target, eventName, () => isEventSupported = true);
  target.dispatchEvent(new Event(eventName));
  return isEventSupported;
}

