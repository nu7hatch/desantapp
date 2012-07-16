Airstrip.SignupResponseMixin = {
    success: function(model, resp) {
        Airstrip.signupFormView.render()
        Airstrip.renderFlash('success', 'Thanks for registering!')
    },
    
    error: function(model, resp) {
        var data = {}

        try { 
            data = JSON.parse(resp.responseText)
        } catch(e) {
            data.error = 'Something went wrong!'
        }

        Airstrip.signupFormView.enable()
        Airstrip.renderFlash('error', data.error)
    },
}

Airstrip.SignupSubmitButtonView = Backbone.View.extend({
    el: '#signup_form_submit',
    
    events: {
        'click': 'submit',
    },

    render: function() {
        this.email = $('#signup_email')
        return this
    },

    enable: function() {
        this.$el.removeAttr("disabled")
        return this
    },
    
    submit: function(e) {
        e.preventDefault()
        
        this.$el.attr("disabled", "disabled")

        signup = new Airstrip.Signup({ email: this.email.val() })
        signup.save({}, Airstrip.SignupResponseMixin)
    }
})

Airstrip.SignupFormView = Backbone.View.extend({
    el: '#signup_form_wrapper',
    template: JST["templates/signup_form"],

    render: function() {
        this.$el.html(this.template())
        this.submitButton = new Airstrip.SignupSubmitButtonView().render()
        return this
    },

    enable: function() {
        if (!!this.submitButton)
            this.submitButton.enable()
        return this;
    }
})
