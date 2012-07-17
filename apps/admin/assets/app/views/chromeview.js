Airstrip.Admin.ChromeView = Backbone.View.extend({
    el: '#yield',
    template: JST['templates/admin/chrome'],

    initialize: function() {

        if (app.session.isAuthenticated()) {
            this.render();
        } else {
            app.navigate('admin/login', true)
        }
    },
    
    render: function() {
        this.$el.html(this.template())
        this.$el.addClass('logged')
        this.navbarView = (new Airstrip.Admin.NavbarView()).render()
        return this
    },

    isRendered: function() {
        return $('#chrome').length == 1
    },

    makeSureRender: function() {
        if (!this.isRendered())
            this.render()
        return this
    }
})
