//= require jquery-1.6.2.min
//= require underscore-1.3.1.min
//= require backbone-0.9.2.min
//= require_tree ../templates
//= require ./airstrip
//= require_tree ./views
//= require_tree ./models

Airstrip.Router = Backbone.Router.extend({
    routes: {
        '': 'home',
    },

    home: function() {
        Airstrip.signupFormView = new Airstrip.SignupFormView({})
        Airstrip.signupFormView.render()
    }
})
