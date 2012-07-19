beforeEach(function() {
    this.addMatchers({
        toBeLessThan: function(expected) {
            return this.actual < expected;
        },
    });
});
