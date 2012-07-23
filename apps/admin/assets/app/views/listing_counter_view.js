/**
 * Public: This is a view for listing counters. It shows a number
 * of the items displayed compared to total count of the listing.
 */
Desant.Admin.ListingCounterView = Backbone.View.extend({
    el: '#counter',
    template: JST['templates/admin/listing_counter'],

    initialize: function() {
        this.total = 0
        this.current = 0
    },
    
    render: function() {
        this.$el.html(this.template({
            count: this.current,
            total_count: this.total,
        }))
        return this
    },

    /**
     * Public: Updates counters with given values and re-renders
     * itself.
     *
     * add   - A Number count of elements added to the listing.
     * total - A Number total count of elements.
     *
     * Returns itself.
     */
    update: function(add, total) {
        this.current += add
        this.total = total
        return this.render()
    }
})
