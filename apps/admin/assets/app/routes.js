Airstrip.Admin.Router = Backbone.Router.extend({
    routes: {
        'admin/': 'home',
        'admin/login': 'login',
        'admin/signups': 'signupsList',
        'admin/locations/cities': 'citiesList',
        'admin/locations/countries': 'countriesList',
        'admin/referers': 'referersList',
    },

    initialize: function() {
        this.session = new Airstrip.Admin.Session();
    },

    home: function() {
        Airstrip.Admin.chromeView.makeSureRender()
        this.navigate('admin/signups', true)
    },
    
    login: function() {
        Airstrip.Admin.loginFormView = new Airstrip.Admin.LoginFormView()
        Airstrip.Admin.loginFormView.render()
    },

    signupsList: function() {
        (new Airstrip.Admin.SignupsListView()).render()
    },

    citiesList: function() {
        (new Airstrip.Admin.LocationsListView({ group: 'cities' })).render()
    },

    countriesList: function() {
        (new Airstrip.Admin.LocationsListView({ group: 'countries' })).render()
    },

    referersList: function() {
        (new Airstrip.Admin.ReferersListView()).render()
    },
})
