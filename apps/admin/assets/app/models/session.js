Airstrip.Admin.Session = Backbone.Model.extend({
    url: '/admin/session',
    
    defaults: {
        login: null,
        password: null,
        access_token: null,
    },

    isAuthenticated: function() {
        return !!this.get('access_token')
    },

    toJSON: function() {
        return this.attributes
    }
})
