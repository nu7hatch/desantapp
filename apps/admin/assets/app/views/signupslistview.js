Airstrip.Admin.SignupListItemsView = Backbone.View.extend({
    el: '#signups tbody',
    template: JST['templates/admin/signup_items'],

    initialize: function() {
        this.signups = new Airstrip.Admin.Signups()
        this.counter = new Airstrip.Admin.ListingCounterView()
        this.isLoading = false
    },
    
    load: function() {
        var self = this
        this.isLoading = true;
        
        this.signups.fetch({
            success: function(collection, resp) {
                self.$el.append(self.template({ signups: collection }))
                self.counter.update(collection.length, collection.total_count)
            },
            error: function(signups, resp) {
                Airstrip.renderFlash('error', "Couldn't load content for the page!")
            }
        }).complete(function() {
            self.isLoading = false
        })

        return this;
    },
    
    render: function() {
        this.load()
        this.signups.page += 1;
        return this
    }
})

Airstrip.Admin.SignupsListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/listing'],

    initialize: function() {
        _.bindAll(this, 'checkScroll')
        bindScroll(this.checkScroll)        
        this.isLoading = false
    },
        
    render: function() {
        this.$el.html(this.template({
            id: 'signups',
            title: "Recently signed users",
            columns: ['#', 'E-mail', 'IP address', 'Registered at'],
        }))

        this.items = new Airstrip.Admin.SignupListItemsView()
        this.items.render()
        
        return this
    },

    checkScroll: function (e) {
        var self = this

        scrollReached(this.isLoading, function() {
            self.items.render()
        })
    }
})
