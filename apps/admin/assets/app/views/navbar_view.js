/**
 * Public: A view for the navigation bar. It handles all the
 * links with '.nav' class so they navigate to the app defined
 * actions.
 */
Airstrip.Admin.NavbarView = Backbone.View.extend({
    el: '#navbar',
    template: JST['templates/admin/navbar'],

    events: {
        'click a.nav': 'clickLink',
    },
    
    render: function() {
        this.$el.html(this.template())
        this.spinner = new Airstrip.Admin.AjaxLoaderView()
        
        return this
    },

    clickLink: function(e) {
        e.preventDefault()
        var $link = $(e.target)
        app.navigate($link.attr('href'), true)
    },
})
