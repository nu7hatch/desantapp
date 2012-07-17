Airstrip.Admin.ListingCounterView = Backbone.View.extend({
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

    update: function(add, total) {
        this.current += add
        this.total = total
        return this.render()
    }
})
