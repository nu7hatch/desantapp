/**
 * Public: A collection of the registered users. It's a reflection
 * of backend's Admin::SignupsPresenter.
 *
 * This collection is paginated.
 */
Airstrip.Admin.Signups = Backbone.Collection.extend({
    url: function() {
        return '/admin/api/signups?page=' + this.page
    },
    page: 1,
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.signups
    }
})
