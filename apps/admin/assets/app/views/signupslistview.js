Airstrip.Admin.SignupsListItemsView = Backbone.View.extend({
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

Airstrip.Admin.SignupsDownloadCSVButtonView = Backbone.View.extend({
    template: JST['templates/admin/download_csv_button'],

    events: {
        'click button.download_csv': 'click',
    },
    
    render: function() {
        this.$el.html(this.template())
        return this;
    },

    click: function(e) {
        e.preventDefault()
        document.location.href = '/admin/signups.csv'
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
            icon: 'user',
            title: "Registered users",
            columns: ['#', 'E-mail', 'IP address', 'Registered at'],
        }))

        this.downloadCSVButton = new Airstrip.Admin.SignupsDownloadCSVButtonView({
            el: this.$('.action_buttons')
        }).render()
        
        this.items = new Airstrip.Admin.SignupsListItemsView().render()
        
        return this
    },

    checkScroll: function (e) {
        var self = this

        scrollReached(this.isLoading, function() {
            self.items.render()
        })
    }
})
