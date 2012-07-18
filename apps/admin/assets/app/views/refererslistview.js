Airstrip.Admin.ReferersListItemsView = Backbone.View.extend({
    el: '#referers tbody',
    template: JST['templates/admin/referer_items'],

    initialize: function() {
        this.referers = new Airstrip.Admin.Referers()
        this.counter = new Airstrip.Admin.ListingCounterView()
        this.isLoading = false
    },
    
    load: function() {
        var self = this
        this.isLoading = true;
        
        this.referers.fetch({
            success: function(collection, resp) {
                self.$el.append(self.template({ referers: collection }))
                self.counter.update(collection.length, collection.total_count)
            },
            error: function(referers, resp) {
                Airstrip.renderFlash('error', "Couldn't load content for the page!")
            }
        }).complete(function() {
            self.isLoading = false
        })

        return this;
    },
    
    render: function() {
        this.load()
        this.referers.page += 1;
        
        return this
    }
})

Airstrip.Admin.ReferersListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/listing'],

    initialize: function() {
        _.bindAll(this, 'checkScroll')
        bindScroll(this.checkScroll)        
        this.isLoading = false
    },
        
    render: function() {
        this.$el.html(this.template({
            id: 'referers',
            icon: 'globe',
            title: "Referring websites",
            columns: ['#', "Referer's URL", 'Brought users'],
        }))

        this.items = new Airstrip.Admin.ReferersListItemsView().render()

        return this
    },

    checkScroll: function (e) {
        var self = this

        scrollReached(this.isLoading, function() {
            self.items.render()
        })
    }
})
