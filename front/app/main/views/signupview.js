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

        signup = new Airstrip.Signup({ email: this.email.val() })
        signup.save({}, {
            success: function(model, response) {
                alert("Yay!")
            },
            error: function(model, response) {
                alert("Argh!")
            }
        })
    }
})

Airstrip.SignupFormView = Backbone.View.extend({
    el: '#signup_form_wrapper',
    template: $('#signup_form_tpl').html(),

    render: function() {
        this.$el.html(this.template)
        this.submitButton = new Airstrip.SignupSubmitButtonView().render()
        return this
    }
})
