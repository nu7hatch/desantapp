/**
 * Public: Reflection of the backend's Desant::Signup model.
 */
Desant.Signup = Backbone.Model.extend({
    url: "/signup",

    toJSON: function() {
        return { 'signup': this.attributes }
    }
})
