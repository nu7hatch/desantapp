Airstrip.Signup = Backbone.Model.extend({
    url: "/signup",

    toJSON: function() {
        return { 'signup': this.attributes }
    }
});
