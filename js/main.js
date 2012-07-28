//=require ./jquery-1.7.2.min.js
//=require ./jquery.scrollTo.js
//=require ./jquery.nav.js
//=require ./scale.fix.js
//=require ./social.js

$(document).ready(function() {
    try {
        $('nav.menu ul').onePageNav({
            currentClass: 'current',
            changeHash: false,
            scrollSpeed: 750,
            scrollOffset: 110,
            scrollThreshold: 0.5,
            filter: '',
            easing: 'swing',
        });
    } catch(e) {
    }

    var $window = $(window);
	var $header = $("header[role='banner']");
	var $shadow = $header.find(".shadow");
	var $logo   = $header.find('.logo img')

	$window.scroll(function(){
        if ($window.scrollTop() > 110) {
            $header.addClass('floating')
            $logo.attr('src', '/images/logo-short.png')
        } else {
            $header.removeClass('floating')
            $logo.attr('src', '/images/logo.png')
        }
	});

    $window.scroll()

    $('a[rel="facebook"]').facebookButton({
        text: "Open source landing pages:",
        url: "http://desantapp.com/",
    })
    $('a[rel="twitter"]').twitterButton({
        text: "Open source landing pages:",
        url: "http://desantapp.com/",
        via: "nu7hatch"
    })
    $('a[rel="plusone"]').plusoneButton({
        url: "http://desantapp.com/"
    })
})
