Airstrip.Admin.LocationsListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/locations_list'],

    render: function() {
        this.$el.html(this.template({
            
        }))
        return this
    },
})
