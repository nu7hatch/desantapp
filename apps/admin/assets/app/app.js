Desant.Admin.Router = Backbone.Router.extend({
    routes: {
        'admin': 'home',
        'admin/': 'home',
        'admin/login': 'login',
        'admin/signups': 'signupsList',
        'admin/locations/cities': 'citiesList',
        'admin/locations/countries': 'countriesList',
        'admin/referers': 'referersList',
    },

    initialize: function() {
        this.session = new Desant.Admin.Session();
    },

    home: function() {
        Desant.Admin.chromeView.makeSureRender()
        this.navigate('admin/signups', true)
    },
    
    login: function() {
        Desant.Admin.loginFormView = new Desant.Admin.LoginFormView()
        Desant.Admin.loginFormView.render()
    },

    signupsList: function() {
        (new Desant.Admin.SignupsListView()).render()
    },

    citiesList: function() {
        (new Desant.Admin.LocationsListView({ group: 'cities' })).render()
    },

    countriesList: function() {
        (new Desant.Admin.LocationsListView({ group: 'countries' })).render()
    },

    referersList: function() {
        (new Desant.Admin.ReferersListView()).render()
    },
})
