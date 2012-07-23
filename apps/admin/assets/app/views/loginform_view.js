/**
 * Public: A view for the login form's submit button. It handles
 * user input and provides submit operation.
 */
Desant.Admin.LoginSubmitButtonView = Backbone.View.extend({
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
        var self = this
        
        this.disable()

        Desant.Admin.router.session.save({
            login: this.login.val(),
            password: this.password.val(),
        }, {
            success: function(model, resp) {
                app.navigate('admin/', true)
                Desant.renderFlash("success", "Welcome home, Master!")
            },
            error: function(model, resp) {
                data = Desant.parseResponse(resp)
                self.enable()
                Desant.renderFlash('error', data.error)
            }
        })
    }
})

_.extend(Desant.Admin.LoginSubmitButtonView.prototype,
         Desant.Mixins.EnableField)

/**
 * Public: The login form view - displays login form and handles
 * user input.
 */
Desant.Admin.LoginFormView = Backbone.View.extend({
    el: '#yield',
    template: JST['templates/admin/login_form'],

    render: function() {
        this.$el.html(this.template())
        this.spinner = new Desant.Admin.AjaxLoaderView()
        this.submitButton = new Desant.Admin.LoginSubmitButtonView({ form: this })
        this.submitButton.render()

        return this
    },
    
    submit: function(e) {
        e.preventDefault()
    },
})
