// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require turbolinks
//= require bootstrap
//= require_tree .

$(document).ready(function(){
   setTimeout(function(){
     $('.alert-wrapper').fadeOut("slow", function(){
       $(this).remove();
     })
   }, 5000);
});

$('.carousel').carousel({
  interval: false,
  pause: "false"
});

jQuery(document).ready(function(){
  $('.scroller').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    dots: true
  });
});

window.onscroll = function() {scrollFunction()};

function scrollFunction() {
    if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
        document.getElementById("nav-index").style.position = "fixed";
        document.getElementById("nav-index").style.background = "rgba(40,54,63,.7)";
    } else {
        document.getElementById("nav-index").style.position = "relative";
        document.getElementById("nav-index").style.background = "none";
    }
}

// mobile nav
$(document).ready(function(){
  if($(window).width() < 1150){
    $(".mobile-menu").click(function(){
        $(".main-links").slideToggle();
    })
  }
});
