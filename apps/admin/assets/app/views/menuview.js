Airstrip.Admin.MenuView = Backbone.View.extend({
    el: '#menu',
    template: JST['templates/admin/menu'],

    events: {
        'click a.nav': 'clickLink',
    },
    
    render: function() {
        this.$el.html(this.template())
        return this
    },

    clickLink: function(e) {
        e.preventDefault()
        var $link = $(e.target)
        app.navigate($link.attr('href'), true)
    }
})
