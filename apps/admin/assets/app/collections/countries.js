/**
 * Public: A collection of the countries from where users have been
 * registered. It's a reflection of backend's Admin::CountriesPresenter.
 *
 * This collection is paginated.
 */
Airstrip.Admin.Countries = Backbone.Collection.extend({
    url: function() {
        return '/admin/api/countries?page=' + this.page
    },
    page: 1,
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.countries
    }
})
