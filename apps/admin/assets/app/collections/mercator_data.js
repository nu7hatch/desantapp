/**
 * Public: A collection of the data used to display markers on
 * the locations (cities or countries) graph.
 */
Desant.Admin.MercatorData = Backbone.Collection.extend({
    url: function() {
        return "/admin/api/" + this.options.group + "/map"
    },

    initialize: function(options) {
        this.options = !!options ? options : {}
    },
    
    parse: function(resp, xhr) {
        this.total_count = resp.total_count
        this.data = resp.data
        return []
    }
})
