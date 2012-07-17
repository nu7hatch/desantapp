Airstrip.Admin.Signup = Backbone.Model.extend({
    defaults: {
        id: null,
        email: null,
        ip_address: null,
        referrer: null,
        created_at: null
    }
})

Airstrip.Admin.Signups = Backbone.Collection.extend({
    url: '/admin/api/signups',
    model: Airstrip.Admin.Signup,

    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.signups
    }
})
