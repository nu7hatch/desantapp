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

window.Desant = {
    Mixins: {},
}
window.Desant.Admin = {
    Mixins: {},
}

$(function() {
    Desant.Admin.router = new Desant.Admin.Router();
    app = Desant.Admin.router
    app.session.fetch().complete(function() {
        Desant.Admin.chromeView = new Desant.Admin.ChromeView()
        Backbone.history.start({ pushState: true })
    })
})
