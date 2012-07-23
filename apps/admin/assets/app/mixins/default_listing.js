/**
 * Public: A view extension for the listing pages.
 *
 * In order to make it work the initListing() function must be
 * called in the view's initializer and initialized models collection
 * must be set, eg:
 *
 *   UsersListItemsView = Backbone.View.extend({
 *       el: '#users tbody',
 *
 *       initialize: function() {
 *           this.models = new Users()
 *           this.initListing()
 *       }
 *   })
 *
 *   _.extend(UsersListItemsView.prototype, Desant.Admin.Mixins.DefaultListing)
 *
 */
Desant.Admin.Mixins.DefaultListing = {
    /**
     * Public: Initializes listing configuration.
     */
    initListing: function() {
        this.counter = new Desant.Admin.ListingCounterView()
        this.isLoading = false
        this.showEmpty = true
        this.done = false
    },

    /**
     * Public: Loads collection items from the server and displays
     * them on the page.
     */
    load: function() {
        var self = this
        this.isLoading = true;
        
        this.models.fetch({
            success: function(collection, resp) {
                self.$el.append(self.template({
                    models: collection,
                    showEmpty: self.showEmpty
                }))
                self.counter.update(collection.length, collection.total_count)
                self.showEmpty = false
                
                if (collection.length == 0) {
                    self.done = true
                }
            },
            error: function(collection, resp) {
                Desant.renderFlash('error', "Couldn't load content for the page!")
            }
        }).complete(function() {
            self.isLoading = false
        })

        return this;
    },

    /**
     * Public: Calls load(), paginates and renders stuff.
     */
    render: function() {
        this.load()
        this.models.page += 1;
        
        return this
    }
}
