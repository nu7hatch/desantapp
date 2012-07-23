/**
 * Public: Provides forms enabling/disabling.
 *
 * In order to use it, extended object must have a this.submitButton
 * field with submit button view (extended by Mixins.EnableField).
 */
Desant.Mixins.EnableForm = {
    /**
     * Public: Enables this form.
     */
    enable: function() {
        if (!!this.submitButton)
            this.submitButton.enable()
        return this;
    },

    /**
     * Public: Disables this form.
     */
    disable: function() {
        if (!!this.submitButton)
            this.submitButton.disable()
        return this;
    }
}

/**
 * Public: Provides enabling/disabling for form fields. Mostly
 * used for buttons.
 */
Desant.Mixins.EnableField = {
    /**
     * Public: Enables this field.
     */
    enable: function() {
        this.$el.removeAttr('disabled')
        return this
    },

    /**
     * Public: Disables this field.
     */
    disable: function() {
        this.$el.attr('disabled', 'disabled')
    },
}
