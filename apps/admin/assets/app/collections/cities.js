/**
 * Public: A collection of the cities from where users have been
 * registered. It's a reflection of backend's Admin::CitiesPresenter.
 *
 * This collection is paginated.
 */
Desant.Admin.Cities = Backbone.Collection.extend({
    url: function() {
        return '/admin/api/cities?page=' + this.page
    },
    page: 1,
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.cities
    }
})
