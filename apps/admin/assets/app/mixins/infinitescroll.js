Airstrip.Admin.Mixins.InifiniteScrollListing = {
    initScroll: function() {
        _.bindAll(this, 'checkScroll')
        bindScroll(this.checkScroll)        
    },
        
    checkScroll: function (e) {
        var self = this

        scrollReached(!this.items.isLoading && !this.items.done, function() {
            self.items.render()
        })
    }
}
