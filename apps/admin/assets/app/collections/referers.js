Airstrip.Admin.Referer = Backbone.Model.extend({
    defaults: {
        id: null,
        url: null,
        users_count: null,
    }
})

Airstrip.Admin.Referers = Backbone.Collection.extend({
    url: function() {
        return '/admin/api/referers?page=' + this.page
    },
    model: Airstrip.Admin.Referer,
    page: 1,
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.referers
    }
})
