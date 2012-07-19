/**
 * Internal: A view and handler for the button to download CSV
 * dump file with all the registered users' information.
 */
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

/**
 * Internal: A view for the registered users list items. It's derived
 * from the default listing.
 */
Airstrip.Admin.SignupsListItemsView = Backbone.View.extend({
    el: '#signups tbody',
    template: JST['templates/admin/signup_items'],

    initialize: function() {
        this.models = new Airstrip.Admin.Signups()
        this.initListing()
    },
})

_.extend(Airstrip.Admin.SignupsListItemsView.prototype,
         Airstrip.Admin.Mixins.DefaultListing)

/**
 * Internal: A view for the registered users list. It's an
 * infinitely scrolled listing.
 */
Airstrip.Admin.SignupsListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/listing'],

    initialize: function() {
        this.initScroll()
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
})

_.extend(Airstrip.Admin.SignupsListView.prototype,
         Airstrip.Admin.Mixins.InifiniteScrollListing)
