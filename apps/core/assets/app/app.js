Airstrip.Router = Backbone.Router.extend({
    routes: {
        '': 'home',
    },

    home: function() {
        Airstrip.signupFormView = new Airstrip.SignupFormView({})
        Airstrip.signupFormView.render()
    }
})
