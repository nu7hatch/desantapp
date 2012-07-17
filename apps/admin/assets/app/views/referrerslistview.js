Airstrip.Admin.ReferrersListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/referrers_list'],

    render: function() {
        this.$el.html(this.template({
            
        }))
        return this
    },
})
