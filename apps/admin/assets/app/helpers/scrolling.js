/**
 * Public: Performs given operation when condition is true and
 * page reached end of the scrolling area.
 *
 * cond     - A Bool condition to be checked.
 * callback - A Function callback to be exectuted.
 *
 */
Desant.Admin.whenScrollReached = function(cond, callback) {
    $window = $(window)
    scrollTop = $window.scrollTop()
    triggerPoint = $(document).height() - $window.height() - 100;

    if (cond && !scrollTop == 0 && scrollTop > triggerPoint) {
        callback()
    }
}

/**
 * Public: Binds given callback with window's onscroll.
 *
 * callback - A Function callback to be bound with scrolling.
 *
 */
Desant.Admin.bindScroll = function(callback) {
    $window = $(window)
    $window.unbind('scroll')
    $window.scroll(callback)
}

/**
 * Public: Unbinds all window's scroll callbacks.
 */
Desant.Admin.unbindScroll = function() {
    $(window).unbind('scroll')
}
