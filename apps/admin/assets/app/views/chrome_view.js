/**
 * Internal: This is the main window layout view. All the
 * widgets displayed across all the pages should be included here.
 * Application should have global instance of this view (eg.
 * app.chromeView).
 */
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

    /**
     * Public: Returns whether chrome is already rendered or not.
     */
    isRendered: function() {
        return $('#chrome').length == 1
    },

    /**
     * Public: Renders composition only if it's not rendered yet.
     */
    makeSureRender: function() {
        if (!this.isRendered())
            this.render()
        return this
    }
})
