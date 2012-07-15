//= require ./main/app

$(function() {
    // Initialize Backbone views.
    Airstrip.router = new Airstrip.Router();

    // Initialize the Backbone router.
    Backbone.history.start({pushState: true});
})
