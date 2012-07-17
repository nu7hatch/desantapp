scrollReached = function(isWorking, callback) {
    $window = $(window)
    scrollTop = $window.scrollTop()
    triggerPoint = $(document).height() - $window.height() - 100;

    if (!isWorking && !scrollTop == 0 && scrollTop > triggerPoint) {
        callback()
    }
}

bindScroll = function(callback) {
    $window = $(window)
    $window.unbind('scroll')
    $window.scroll(callback)
}

unbindScroll = function(callback) {
    $(window).unbind('scroll')
}
