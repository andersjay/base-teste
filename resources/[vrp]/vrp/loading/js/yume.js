$(function() {
    "use strict";
    $(window).on("load", function() {
        $("#preloader").fadeOut(600);
        $(".preloader-bg").delay(400).fadeOut(600);
        setTimeout(function() {
            $(".fadeIn-element").delay(1600).css({
                display: "none"
            }).fadeIn(2400);
        }, 0);
        setTimeout(function() {
            $(".top-element").removeClass("top-position");
        }, 600);
        setTimeout(function() {
            $(".bottom-element, .bottom-element-menu").removeClass("bottom-position");
        }, 600);
        setTimeout(function() {
            $(".left-element").removeClass("left-position");
        }, 600);
        setTimeout(function() {
            $(".right-element").removeClass("right-position");
        }, 600);
    });
    $("#bgndVideo").YTPlayer();
})


var audio_element = document.getElementById("audio");

function playPause() { 
    if (audio_element.paused) {
        audio_element.play();
        }
    else  {
        audio_element.pause();
        }
} 

document.onkeydown = function(event) {
    switch (event.keyCode) {
       case 38:
            event.preventDefault();
            audio_vol = audio_element.volume;
            if (audio_vol!=1) {
              try {
                  audio_element.volume = audio_vol + 0.10;
              }
              catch(err) {
                  audio_element.volume = 1;
              }
              
            }
            
          break;
       case 40:
            event.preventDefault();
            audio_vol = audio_element.volume;
            if (audio_vol!=0) {
              try {
                  audio_element.volume = audio_vol - 0.10;
              }
              catch(err) {
                  audio_element.volume = 0;
              }
              
            }
            
          break;
       case 32:
            event.preventDefault();
            audio_vol = audio_element.volume;
            playPause();
            console.log("asaasa")
          break;
    }
};


var audio;
var playlist;
var tracks;
var current;

var playlistmusic = [
    ""
];

shuffle(playlistmusic);

init();
function init(){
    current = 0;
    audio = $('audio');
    audio[0].volume = .40;
    len = playlistmusic.length;
    
    run(playlistmusic[current], audio[0]);
    
    audio[0].addEventListener('ended',function(e){
        current++;
        if(current == len){
            current = 0;
        }
        run(playlistmusic[current],audio[0]);
    });
}

function run(link, player){
        player.src = link;
        audio[0].load();
        audio[0].play();
        $('#playing').html("<ul><li><a>" + link+ "</a></li></ul>");     
}

function shuffle(array) {
  var currentIndex = array.length, temporaryValue, randomIndex ;

  // While there remain elements to shuffle...
  while (0 !== currentIndex) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}


