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
