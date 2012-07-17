Airstrip.Admin.Router = Backbone.Router.extend({
    routes: {
        'admin/': 'home',
        'admin/login': 'login',
        'admin/signups': 'signupsList',
    },

    initialize: function() {
        this.session = new Airstrip.Admin.Session();
    },

    home: function() {        
        this.navigate('admin/signups', true)
    },
    
    login: function() {
        Airstrip.Admin.loginFormView = new Airstrip.Admin.LoginFormView()
        Airstrip.Admin.loginFormView.render()
    },

    signupsList: function() {
        Airstrip.Admin.signupsListView = new Airstrip.Admin.SignupsListView()
        Airstrip.Admin.signupsListView.render()
    }
})
