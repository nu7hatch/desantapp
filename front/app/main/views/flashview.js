Airstrip.renderFlash = function(type, message) {
    flash = new Airstrip.Flash({ type: type, message: message })
    flash.render()
}

Airstrip.Flash = Backbone.View.extend({
    el: '#flash',
    template: JST["templates/flash"],
    
    events: {
        'click .hide': 'hide'
    },

    render: function() {
        this.$el.html(this.template({
            message: this.options.message,
            type: this.options.type,
        }))
        return this
    },

    hide: function(e) {
        e.preventDefault();
        this.$el.html('');
    }
})
