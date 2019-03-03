//JavaScript for a sildeshow object
//track the index of the slideshow
var slideIndex = 1;
function moveSlideIndex(n) {
  slideIndex += n;
  var slides = document.getElementsByClassName("travelSlide");
  if (slideIndex > slides.length) { slideIndex = 1 }
  if (slideIndex < 1) { slideIndex = slides.length }
  showSlides();
}
//rules for moving the index
function showSlides() {
  var slides = document.getElementsByClassName("travelSlide");
  for (var i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  slides[slideIndex-1].style.display = "block";
}