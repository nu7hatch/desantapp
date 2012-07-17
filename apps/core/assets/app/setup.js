//= require jquery-1.6.2.min
//= require underscore-1.3.1.min
//= require backbone-0.9.2.min
//= require ./airstrip
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./mixins
//= require_tree ./views
//= require_tree ./models
//= require ./routes

$(function() {
    Airstrip.router = new Airstrip.Router();
    Backbone.history.start({ pushState: true });
})
