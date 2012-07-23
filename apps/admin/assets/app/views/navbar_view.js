/**
 * Public: A view for the navigation bar. It handles all the
 * links with '.nav' class so they navigate to the app defined
 * actions.
 */
Desant.Admin.NavbarView = Backbone.View.extend({
    el: '#navbar',
    template: JST['templates/admin/navbar'],

    events: {
        'click a.nav': 'clickLink',
    },
    
    render: function() {
        this.$el.html(this.template())
        this.spinner = new Desant.Admin.AjaxLoaderView()

        var $current = this.$('a.nav[href="' + document.location.pathname + '"]')
        $current.addClass('current')
        
        return this
    },

    clickLink: function(e) {
        e.preventDefault()
        this.$('a.nav').removeClass('current')

        var $link = $(e.target)
        $link.addClass('current')

        app.navigate($link.attr('href'), true)
    },
})
