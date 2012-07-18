Airstrip.SignupSubmitButtonView = Backbone.View.extend({
    el: '#signup_form_submit',
    
    events: {
        'click': 'submit',
    },

    render: function() {
        this.email = $('#signup_email')
        return this
    },

    submit: function(e) {
        e.preventDefault()
        
        this.$el.attr("disabled", "disabled")

        signup = new Airstrip.Signup({ email: this.email.val() })
        signup.save({}, {
            success: function(model, resp) {
                Airstrip.signupFormView.render()
                Airstrip.renderFlash('success', 'Thanks for registering!')
            },

            error: function(model, resp) {
                var data = Airstrip.parseResponse(resp)
                Airstrip.signupFormView.enable()
                Airstrip.renderFlash('error', data.error)
            }
        })
    }
})

_.extend(Airstrip.SignupSubmitButtonView.prototype, Airstrip.Mixins.EnableField)

Airstrip.SignupFormView = Backbone.View.extend({
    el: '#signup_form_wrapper',
    template: JST["templates/signup_form"],

    render: function() {
        this.$el.html(this.template())

        this.submitButton = new Airstrip.SignupSubmitButtonView({ form: this })
        this.submitButton.render()

        return this
    },
})

_.extend(Airstrip.SignupFormView.prototype, Airstrip.Mixins.EnableForm);

