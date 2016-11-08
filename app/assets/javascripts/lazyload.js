import debounce from 'lodash.debounce';
import { queryAll, isElementInViewport, setImageSrc } from './dom';

const sourceAttribute = 'data-src';

export function loadImage(img) {
  img.classList.add('loading');
  return setImageSrc(img, img.getAttribute(sourceAttribute)).then(data => {
    img.classList.remove('loading');
    img.classList.add('loaded');
    return data;
  });
}

export function loadImages(
  win,
  selector = `img[${sourceAttribute}][src=""], img[${sourceAttribute}]:not([src])`,
  onlyVisibles = true
) {
  const doc = win.document;

  let images = queryAll(doc, selector);
  if (onlyVisibles) {
    images = images.filter(img => isElementInViewport(img, win));
  }

  return Promise.all(images.map(loadImage));
}

export function lazyload({
  win = window,
  doc = win.document,
  onlyVisibles,
  selector,
  updateDeboundRate = 100
} = {}) {
  const update = debounce(() => loadImages(win, selector, onlyVisibles), updateDeboundRate);
  ['resize', 'scroll'].forEach(eventName => doc.addEventListener(eventName, update));
  update();
  return update;
}
