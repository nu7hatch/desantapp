/**
 * Internal: A view for the referers list items. It's derived from
 * the default listing.
 */
Desant.Admin.ReferersListItemsView = Backbone.View.extend({
    el: '#referers tbody',
    template: JST['templates/admin/referer_items'],

    initialize: function() {
        this.models = new Desant.Admin.Referers()
        this.initListing()
    },
})

_.extend(Desant.Admin.ReferersListItemsView.prototype,
         Desant.Admin.Mixins.DefaultListing)

/**
 * Internal: A view for the refering websites list. It's an
 * infinitely scrolled listing.
 */
Desant.Admin.ReferersListView = Backbone.View.extend({
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

        this.items = new Desant.Admin.ReferersListItemsView().render()

        return this
    },
})

_.extend(Desant.Admin.ReferersListView.prototype,
         Desant.Admin.Mixins.InifiniteScrollListing)
