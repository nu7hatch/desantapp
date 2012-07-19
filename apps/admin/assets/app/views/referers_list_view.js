/**
 * Internal: A view for the referers list items. It's derived from
 * the default listing.
 */
Airstrip.Admin.ReferersListItemsView = Backbone.View.extend({
    el: '#referers tbody',
    template: JST['templates/admin/referer_items'],

    initialize: function() {
        this.models = new Airstrip.Admin.Referers()
        this.initListing()
    },
})

_.extend(Airstrip.Admin.ReferersListItemsView.prototype,
         Airstrip.Admin.Mixins.DefaultListing)

/**
 * Internal: A view for the refering websites list. It's an
 * infinitely scrolled listing.
 */
Airstrip.Admin.ReferersListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/listing'],

    initialize: function() {
        this.initScroll()
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
})

_.extend(Airstrip.Admin.ReferersListView.prototype,
         Airstrip.Admin.Mixins.InifiniteScrollListing)
