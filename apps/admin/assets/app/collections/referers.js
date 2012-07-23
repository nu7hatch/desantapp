/**
 * Public: A collection of the websites which referred registered
 * users. It's a reflection of backend's Admin::ReferersPresenter.
 *
 * This collection is paginated.
 */
Desant.Admin.Referers = Backbone.Collection.extend({
    url: function() {
        return '/admin/api/referers?page=' + this.page
    },
    page: 1,
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        return resp.referers
    }
})
