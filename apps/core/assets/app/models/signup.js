/**
 * Public: Reflection of the backend's Airstrip::Signup model.
 */
Airstrip.Signup = Backbone.Model.extend({
    url: "/signup",

    toJSON: function() {
        return { 'signup': this.attributes }
    }
})
