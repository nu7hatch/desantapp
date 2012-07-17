Airstrip.Admin.LoginSubmitButtonView = Backbone.View.extend({
    el: '#login_form_submit',
    
    events: {
        'click': 'submit',
    },

    render: function() {
        this.login = $('#login_user')
        this.password = $('#login_password')
        
        return this
    },

    submit: function(e) {
        e.preventDefault()
        
        this.$el.attr("disabled", "disabled")

        Airstrip.Admin.router.session.save({
            login: this.login.val(),
            password: this.password.val(),
        }, {
            success: function(model, resp) {
                Airstrip.renderFlash("success", "Successfully logged in!")
                console.log(model)
                console.log(Airstrip.Admin.router.session)
                app.navigate('admin/', true)
            },
            error: function(model, resp) {
                data = Airstrip.parseResponse(resp)
                Airstrip.Admin.loginFormView.enable()
                Airstrip.renderFlash('error', data.error)
            }
        })
    }
})

_.extend(Airstrip.Admin.LoginSubmitButtonView.prototype,
         Airstrip.Mixins.EnableField)

Airstrip.Admin.LoginFormView = Backbone.View.extend({
    el: '#yield',
    template: JST['templates/admin/login_form'],

    render: function() {
        this.$el.html(this.template())

        this.submitButton = new Airstrip.Admin.LoginSubmitButtonView({
            form: this
        })
        this.submitButton.render()

        return this
    },
    
    submit: function(e) {
        e.preventDefault()
    },
})

_.extend(Airstrip.Admin.LoginFormView.prototype,
         Airstrip.Mixins.EnableForm);
