/**
 * Internal: A view for the signup form submit button.
 */
Desant.SignupSubmitButtonView = Backbone.View.extend({
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

        signup = new Desant.Signup({ email: this.email.val() })
        signup.save({}, {
            success: function(model, resp) {
                Desant.signupFormView.render()
                Desant.renderFlash('success', 'Thanks for registering!')
            },

            error: function(model, resp) {
                self.enable()
                var data = Desant.parseResponse(resp)
                Desant.renderFlash('error', data.error)
            }
        })
    }
})

_.extend(Desant.SignupSubmitButtonView.prototype, Desant.Mixins.EnableField)

/**
 * Internal: A view for the signup form. The 'div#signup_form_wrapper'
 * DOM Object must be defined in order to make it work.
 */
Desant.SignupFormView = Backbone.View.extend({
    el: '#signup_form_wrapper',
    template: JST["templates/signup_form"],

    render: function() {
        this.$el.html(this.template())

        this.submitButton = new Desant.SignupSubmitButtonView({ form: this })
        this.submitButton.render()

        return this
    },
})
