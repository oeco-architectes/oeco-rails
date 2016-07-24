function carousel(element) {
  const slidesCount = element.querySelectorAll('.carousel__item').length;
  const playingClass = 'carousel--playing';
  const slides = element.querySelector('.carousel__slides');
  const activeNavItems = Array.prototype.slice.call(element.querySelectorAll('.carousel__nav-item'));
  const activeNavItemClass = 'carousel__nav-item--active';

  let currentIndex;
  let playInterval;
  let playDelay;
  let activeNavItem;

  function updateActiveSlide(index) {
    currentIndex = index;
    slides.style.transform = `translateX(-${100 * currentIndex}%)`;
    if (activeNavItem) {
      activeNavItem.classList.remove(activeNavItemClass);
    }
    if (currentIndex !== undefined) {
      activeNavItem = activeNavItems[currentIndex];
      activeNavItem.classList.add(activeNavItemClass);
    }
  }

  function next() {
    updateActiveSlide((currentIndex + 1) % slidesCount);
  }

  function previous() {
    updateActiveSlide((currentIndex - 1 + slidesCount) % slidesCount);
  }

  function updateIsPlaying(isPlaying) {
    if (isPlaying) {
      element.classList.add(playingClass);
    } else {
      element.classList.remove(playingClass);
    }
  }

  function stopTimer() {
    if (playInterval) {
      clearInterval(playInterval);
      playInterval = null;
    }
  }

  function play(delay) {
    stopTimer();
    playDelay = delay;
    playInterval = setInterval(next, delay);
    updateIsPlaying(true);
  }

  function pause() {
    stopTimer();
    updateIsPlaying(false);
  }

  function onClick({ target }) {
    if (target.hasAttribute('data-carousel-next')) {
      pause();
      next();
    }
    if (target.hasAttribute('data-carousel-previous')) {
      pause();
      previous();
    }
    if (target.hasAttribute('data-carousel-play')) {
      if (playDelay) {
        play(playDelay);
      }
    }
    if (target.hasAttribute('data-carousel-pause')) {
      pause();
    }
  }

  function dispose() {
    stopTimer();
    element.removeEventListener('click', onClick);
    updateActiveSlide();
  }

  element.addEventListener('click', onClick);

  updateActiveSlide(0);
  return { play, pause, previous, next, dispose };
}

$(document).on('ready turbolinks:load', (e) => {
  const element = document.querySelector('.carousel');
  if (element) {
    const { play, dispose } = carousel(element);
    $(document).one('turbolinks:before-visit', dispose);
    play(5000);
  }
});
