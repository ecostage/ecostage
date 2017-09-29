// slider - últimos projetos desenvolvidos
$(document).ready(function() {
  $("#js-our-projects").owlCarousel({
    navigation : true, // Show next and prev buttons
    slideSpeed : 300,
    paginationSpeed : 400,
    singleItem : true
  });

  $('#js-contact').click(function() {
    HS.beacon.toggle();
  });
});
