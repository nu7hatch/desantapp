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
