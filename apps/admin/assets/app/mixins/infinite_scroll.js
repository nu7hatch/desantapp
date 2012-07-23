/**
 * Public: A mixin providing infinite scroll pagination in
 * listing views.
 *
 * In order to make it work initScroll() must be called from
 * view's initializer, eg:
 *
 *   UsersListView = Backbone.View.extend({
 *       initialize: function() {
 *           this.initScroll()
 *       }
 *   })
 *
 *   _.extend(UsersListView.prototype, Desant.Admin.Mixins.InifiniteScrollListing)
 */
Desant.Admin.Mixins.InifiniteScrollListing = {
    /**
     * Public: Initializez infinite scrolling configuration.
     */
    initScroll: function() {
        _.bindAll(this, 'checkScroll')
        Desant.Admin.bindScroll(this.checkScroll)        
    },

    /**
     * Internal: A callback for window's scroll event.
     *
     * e - An Event passed by the caller.
     *
     */
    checkScroll: function(e) {
        var self = this
        condition = !this.items.isLoading && !this.items.done
        
        Desant.Admin.whenScrollReached(condition, function() {
            self.items.render()
        })
    }
}
