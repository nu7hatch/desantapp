/**
 * Internal: A view for the cities list items. It's derived from
 * the default listing.
 */
Airstrip.Admin.CitiesListItemsView = Backbone.View.extend({
    el: '#cities tbody',
    template: JST['templates/admin/city_items'],

    initialize: function() {
        this.models = new Airstrip.Admin.Cities()
        this.initListing()
    },
})

_.extend(Airstrip.Admin.CitiesListItemsView.prototype,
         Airstrip.Admin.Mixins.DefaultListing)

/**
 * Internal: A view for the countries list items. It's derived from
 * the default listing.
 */
Airstrip.Admin.CountriesListItemsView = Backbone.View.extend({
    el: '#countries tbody',
    template: JST['templates/admin/country_items'],

    initialize: function() {
        this.models = new Airstrip.Admin.Countries()
        this.initListing()
    },
})

_.extend(Airstrip.Admin.CountriesListItemsView.prototype,
         Airstrip.Admin.Mixins.DefaultListing)

/**
 * Internal: A shared view for the locations list. It can either
 * display list of cities or countries, dependent on the 'group'
 * option specified. It's an infinitely scrolled listing.
 */
Airstrip.Admin.LocationsListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/listing'],
    subnav_template: JST['templates/admin/locations_subnav'],

    events: {
        'click .tab': 'switchTab',
    },
    
    initialize: function() {
        this.initScroll()
    },

    render: function() {
        if (this.options.group == 'cities') {
            this.renderCities()
        } else {
            this.renderCountries()
        }

        return this
    },

    /**
     * Internal: Switches tab to specified one and navigates to related
     * action.
     *
     * to - A String name of the tab to switch (can be 'cities' or 'countries')
     *
     */
    navigate: function(to) {
        app.navigate(to)
        
        this.$('.subnav').html(this.subnav_template())
        this.$('.subnav .' + this.options.group + '_tab').addClass('current')
    },

    /**
     * Internal: Renders list of the cities.
     */
    renderCities: function() {
        this.$el.html(this.template({
            id: 'cities',
            icon: 'map-marker',
            title: "User locations",
            columns: ['#', 'City', 'Country', 'Total users'],
        }))

        this.navigate('/admin/locations/cities')
        
        this.items = new Airstrip.Admin.CitiesListItemsView().render()
        this.map = new Airstrip.Admin.LocationsMapView({ group: 'cities' }).render()

        return this
    },

    /**
     * Internal: Renders list of the countries.
     */
    renderCountries: function() {
        this.$el.html(this.template({
            id: 'countries',
            icon: 'map-marker',
            title: "User locations",
            columns: ['#', 'Country', 'Total users'],
        }))

        this.navigate('/admin/locations/countries')

        this.items = new Airstrip.Admin.CountriesListItemsView().render()
        this.map = new Airstrip.Admin.LocationsMapView({ group: 'countries' }).render()

        return this
    },

    /**
     * Internal: An event fired when user clicks on one of the tabs -
     * 'By cities' or 'By countries' and switches listing context to
     * appropriate one.
     *
     * e - An Event passed by the caller.
     *
     */
    switchTab: function(e) {
        e.preventDefault()

        group = $(e.target).data('group')

        if (this.options.group != group) {
            this.options.group = group
            this.render()
        }
    },
})

_.extend(Airstrip.Admin.LocationsListView.prototype,
         Airstrip.Admin.Mixins.InifiniteScrollListing)
