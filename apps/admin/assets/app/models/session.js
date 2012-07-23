/**
 * Public; Admin sessions logic. App should have one global
 * instance of this model (eg. app.session).
 */
Desant.Admin.Session = Backbone.Model.extend({
    url: '/admin/session',
    
    defaults: {
        login: null,
        password: null,
        access_token: null,
    },

    /**
     * Public: Returns whether current session is authenticated
     * or not.
     */
    isAuthenticated: function() {
        return !!this.get('access_token')
    },

    toJSON: function() {
        return this.attributes
    }
})
