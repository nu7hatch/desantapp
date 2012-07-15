//= require jquery-1.6.2.min
//= require underscore-1.3.1.min
//= require backbone-0.9.2.min
//= require ./airstrip
//= require_tree ./views
//= require_tree ./models

Airstrip.Router = Backbone.Router.extend({
    routes: {
        '': 'home',
    },

    home: function() {
        signupForm = new Airstrip.SignupFormView({})
        signupForm.render()
    }
})
