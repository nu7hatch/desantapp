Airstrip.Admin.ReferersListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/referers_list'],

    render: function() {
        this.$el.html(this.template({
            
        }))
        return this
    },
})
