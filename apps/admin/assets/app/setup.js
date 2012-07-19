//= require jquery-1.6.2.min
//= require underscore-1.3.1.min
//= require backbone-0.9.2.min
//= require moment-1.6.2.min
//= require d3-2.9.1.min
//
//= require_self
//
//= require templates/flash
//= require views/flash_view
//= require mixins/enable_form
//= require helpers/common_helpers
//
//= require_tree ./helpers
//= require_tree ./mixins
//= require_tree ./templates
//= require_tree ./views
//= require_tree ./models
//= require_tree ./collections
//
//= require ./app

window.Airstrip = {
    Mixins: {},
}
window.Airstrip.Admin = {
    Mixins: {},
}

$(function() {
    Airstrip.Admin.router = new Airstrip.Admin.Router();
    app = Airstrip.Admin.router
    app.session.fetch().complete(function() {
        Airstrip.Admin.chromeView = new Airstrip.Admin.ChromeView()
        Backbone.history.start({ pushState: true })
    })
})
