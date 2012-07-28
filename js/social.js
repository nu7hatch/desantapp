function updateSocialCounters() {
    $('a.socialBtn span.count').updateSocialCounter()
}

(function($) {
    var increaseCounter = function(link) {
        $counter = $(link).find('.count')
        console.log($counter)
        $counter.html(parseInt($counter.html()) + 1)
    }
    
    $.fn.updateSocialCounter = function() {
        this.each(function(_, counter) {
            $counter = $(counter);
            var rel = $counter.parent('a').attr('rel')
            $counter.html(Exoteric.count(rel))

        })
    }
    
    $.fn.facebookButton = function(opts) {
        $window = $(window)
        
        opts = !!opts ? opts : {}
        
        var text = !!opts.text ? opts.text : document.title
          , url = !!opts.url ? opts.url : document.location.href

        var facebookUrl = 'http://www.facebook.com/sharer.php?'
        facebookUrl += 'u=' + encodeURIComponent(url)
        facebookUrl += '&t=' + encodeURIComponent(text)
            
        this.attr('href', facebookUrl).click(function(e) {
            var width = 480
              , height = 350
              , left = ($window.width() - width) / 2
              , top = ($window.height() - height) / 2
              , opts = 'status=1' + ',width=' + width  + ',height=' + height + ',top=' + top + ',left=' + left

            increaseCounter(this)
            window.open(this.href, 'facebook', opts)
            return false
        })
    }
    
    $.fn.plusoneButton = function(opts) {
        $window = $(window)
        
        opts = !!opts ? opts : {}
        
        var text = !!opts.text ? opts.text : document.title
          , url = !!opts.url ? opts.url : document.location.href

        var plusoneUrl = 'https://plusone.google.com/_/+1/confirm?'
        plusoneUrl += 'hl=en-US'
        plusoneUrl += '&url=' + encodeURIComponent(url)

        this.attr('href', plusoneUrl).click(function(e) {
            var width = 460
              , height = 450
              , left = ($window.width() - width) / 2
              , top = ($window.height() - height) / 2
              , opts = 'scrollbars=Yes,status=1' + ',width=' + width  + ',height=' + height + ',top=' + top + ',left=' + left

            increaseCounter(this)
            window.open(this.href, 'plusone', opts)
            return false
        })
    }

    $.fn.twitterButton = function(opts) {
        $window = $(window)
        
        opts = !!opts ? opts : {}
        
        var text = !!opts.text ? opts.text : document.title
          , url = !!opts.url ? opts.url : document.location.href
          , via = opts.via

        var tweetUrl = 'http://twitter.com/share?'
        tweetUrl += 'url=' + encodeURIComponent(url)
        tweetUrl += '&text=' + encodeURIComponent(text)
        if (!!via) tweetUrl += '&via=' + via
        
        this.attr('href', tweetUrl).click(function(e) {
            var width = 575
              , height = 300
              , left = ($window.width() - width) / 2
              , top = ($window.height() - height) / 2
              , opts = 'status=1' + ',width=' + width  + ',height=' + height + ',top=' + top + ',left=' + left

            increaseCounter(this)
            window.open(this.href, 'twitter', opts)
            return false
        })
    }
})(jQuery)
