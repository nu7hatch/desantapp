/**
 * Internal: A view for the ajax loader. It's magically bound
 * to all the ajax start/stop events, so you don't have to worry
 * about it at all.
 */
Desant.Admin.AjaxLoaderView = Backbone.View.extend({
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
