Airstrip.Admin.Country = Backbone.Model.extend({
    defaults: {
        id: null,
        country: null,
        users_count: null,
    }
})

Airstrip.Admin.Countries = Backbone.Collection.extend({
    url: function() {
        return '/admin/api/countries?page=' + this.page
    },
    model: Airstrip.Admin.Country,
    page: 1,
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.countries
    }
})
