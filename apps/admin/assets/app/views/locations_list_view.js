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
    
    navigate: function(to) {
        app.navigate(to)
        
        this.$('.subnav').html(this.subnav_template())
        this.$('.subnav .' + this.options.group + '_tab').addClass('current')
    },
    
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
