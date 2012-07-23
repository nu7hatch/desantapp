//= require jquery-1.6.2.min
//= require underscore-1.3.1.min
//= require backbone-0.9.2.min
//
//= require_self
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./mixins
//= require_tree ./views
//= require_tree ./models
//
//= require ./app

window.Desant = {
    Mixins: {},
}

$(function() {
    Desant.router = new Desant.Router();
    Backbone.history.start({ pushState: true });
})
