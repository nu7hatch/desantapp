Airstrip.Admin.City = Backbone.Model.extend({
    defaults: {
        id: null,
        city: null,
        country: null,
        users_count: null,
    }
})

Airstrip.Admin.Cities = Backbone.Collection.extend({
    url: function() {
        return '/admin/api/cities?page=' + this.page
    },
    model: Airstrip.Admin.City,
    page: 1,
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.cities
    }
})
