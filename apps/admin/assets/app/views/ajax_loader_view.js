Airstrip.Admin.AjaxLoaderView = Backbone.View.extend({
    el: '#ajax_loader',

    events: {
        'ajaxStart': 'show',
        'ajaxStop': 'hide',
    },
    
    show: function() {
        this.$el.show()
    },

    hide: function() {
        this.$el.hide()
    }
})
