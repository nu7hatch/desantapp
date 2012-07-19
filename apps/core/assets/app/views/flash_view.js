/**
 * Public: A helper for quick rendering of the flash message.
 *
 * type    - A String kind of the flash message (can be error,
 *           warning, success or info)
 * message - A String message to be displayed in this flash.
 *
 */
Airstrip.renderFlash = function(type, message) {
    flash = new Airstrip.Flash({ type: type, message: message })
    flash.render()
}

/**
 * Public: A view for the flash messages. The 'div#flash' DOM
 * object must be defined in order to make it work.
 */
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
