Airstrip.Admin.Mixins.DefaultListing = {
    initListing: function() {
        this.counter = new Airstrip.Admin.ListingCounterView()
        this.isLoading = false
        this.done = false
    },
    
    load: function() {
        var self = this
        this.isLoading = true;
        
        this.models.fetch({
            success: function(collection, resp) {
                if (collection.length > 0) {
                    self.$el.append(self.template({ models: collection }))
                    self.counter.update(collection.length, collection.total_count)
                } else {
                    self.done = true
                }
            },
            error: function(collection, resp) {
                Airstrip.renderFlash('error', "Couldn't load content for the page!")
            }
        }).complete(function() {
            self.isLoading = false
        })

        return this;
    },
    
    render: function() {
        this.load()
        this.models.page += 1;
        
        return this
    }
}
