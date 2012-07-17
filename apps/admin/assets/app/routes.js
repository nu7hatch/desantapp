Airstrip.Admin.Router = Backbone.Router.extend({
    routes: {
        'admin/': 'home',
        'admin/login': 'login',
        'admin/signups': 'signupsList',
        'admin/locations': 'locationsList',
        'admin/referrers': 'referrersList',
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

    locationsList: function() {
        (new Airstrip.Admin.LocationsListView()).render()
    },

    referrersList: function() {
        (new Airstrip.Admin.ReferrersListView()).render()
    },
})
