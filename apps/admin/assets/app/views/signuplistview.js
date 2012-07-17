Airstrip.Admin.SignupsListView = Backbone.View.extend({
    el: '#content',
    template: JST['templates/admin/signups_list'],

    render: function() {
        var self = this
        
        var signups = new Airstrip.Admin.Signups()
        signups.fetch({
            success: function(collection, resp) {
                self.$el.html(self.template({
                    signups: collection
                }))
            },
            error: function(signups, resp) {
                Airstrip.renderFlash('error', "Couldn't load content for the page!")
            }
        })
        
        return this
    },
})
