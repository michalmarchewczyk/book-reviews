function RatingInput_setRating(el) {
    const value = el.dataset['value'];
    const inputId = el.dataset['inputId'];
    const input = document.getElementById(inputId);
    input.value = value;
    const container = el.parentElement;
    const stars = container.querySelectorAll('.comp-RatingInput-star');

    stars.forEach(star => {
        if (star.dataset['value'] <= value) {
            star.children[0].classList.add('bi-star-fill');
            star.children[0].classList.remove('bi-star');
        } else {
            star.children[0].classList.add('bi-star');
            star.children[0].classList.remove('bi-star-fill');
        }
    });
}