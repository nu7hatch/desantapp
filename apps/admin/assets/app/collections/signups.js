Airstrip.Admin.Signup = Backbone.Model.extend({
    defaults: {
        id: null,
        email: null,
        ip_address: null,
        referer: null,
        created_at: null
    }
})

Airstrip.Admin.Signups = Backbone.Collection.extend({
    url: function() {
        return '/admin/api/signups?page=' + this.page
    },
    model: Airstrip.Admin.Signup,
    page: 1,
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.signups
    }
})
