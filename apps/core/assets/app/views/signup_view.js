/**
 * Internal: A view for the signup form submit button.
 */
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
        var self = this
        
        this.disable()

        signup = new Airstrip.Signup({ email: this.email.val() })
        signup.save({}, {
            success: function(model, resp) {
                Airstrip.signupFormView.render()
                Airstrip.renderFlash('success', 'Thanks for registering!')
            },

            error: function(model, resp) {
                self.enable()
                var data = Airstrip.parseResponse(resp)
                Airstrip.renderFlash('error', data.error)
            }
        })
    }
})

_.extend(Airstrip.SignupSubmitButtonView.prototype, Airstrip.Mixins.EnableField)

/**
 * Internal: A view for the signup form. The 'div#signup_form_wrapper'
 * DOM Object must be defined in order to make it work.
 */
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
