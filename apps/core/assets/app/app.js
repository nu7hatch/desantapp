Desant.Router = Backbone.Router.extend({
    routes: {
        '': 'home',
    },

    home: function() {
        Desant.signupFormView = new Desant.SignupFormView({})
        Desant.signupFormView.render()
    }
})
