Airstrip.Mixins.EnableForm = {
    enable: function() {
        if (!!this.submitButton)
            this.submitButton.enable()
        return this;
    },
}

Airstrip.Mixins.EnableField = {
    enable: function() {
        this.$el.removeAttr("disabled")
        return this
    },
}
