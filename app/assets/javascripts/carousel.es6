function carousel(element) {
  const slidesCount = element.querySelectorAll('.carousel__item').length;
  const activeClass = 'carousel__item--active';
  const playingClass = 'carousel--playing';
  const style = element.querySelector('.carousel__slides').style;

  let currentIndex;
  let playInterval;
  let playDelay;

  function updateActiveSlide(index = 0) {
    currentIndex = index;
    style.transform = `translateX(-${100 * currentIndex}%)`;
  }

  function next() {
    updateActiveSlide((currentIndex + 1) % slidesCount);
  }

  function previous() {
    updateActiveSlide((currentIndex - 1) % slidesCount);
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
  }

  element.addEventListener('click', onClick);

  updateActiveSlide();
  return { play, pause, previous, next, dispose };
}

$(document).ready(() => {
  const { play, dispose } = carousel(document.querySelector('.carousel'));
  $(document).one('turbolinks:before-visit', dispose);
  play(5000);
});
