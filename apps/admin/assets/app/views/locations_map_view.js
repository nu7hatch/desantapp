Airstrip.Admin.LocationsMapView = Backbone.View.extend({
    el: '.extras',
    template: '<div id="map"><svg></svg></div>',

    render: function() {
        this.$el.html(this.template)
        this.$map = this.$('#map')

        graph = this.buildGraph()
        graph.load(this.options.group)

        return this
    },

    buildGraph: function() {
        this.margin = { top: 0, right: 0, bottom: 0, left: 0 }
        this.width  = 800 - this.margin.left - this.margin.right
        this.height = this.$map.height() - this.margin.top - this.margin.bottom

        
        this.projection = d3.geo.mercator()
            .scale(this.width)
            .translate([ this.width / 2, this.height / 2 ])
        
        this.path = d3.geo.path()
            .projection(this.projection)

        this.svg = d3.select("#map svg")
            .attr("width", this.width + this.margin.left + this.margin.right)
            .attr("height", this.height + this.margin.top + this.margin.bottom)
            .append("g")
            .attr("transform", "translate(" + this.margin.left + "," + this.margin.top + ")")

        this.feature = this.svg
            .append("g")
            .selectAll(".feature")

        return this
    },
    
    load: function(group) {
        var self = this
        
        mercatorData = new (Backbone.Collection.extend({
            url: function() {
                return "/admin/api/" + group + "/map"
            },
            
            parse: function(resp, xhr) {
                this.total_count = resp.total_count
                this.data = resp.data
                return []
            }
        }))()
        
        mercatorData.fetch({
            success: function(collection, resp) {
                if (group == 'countries') {
                    self.drawCountries(collection.total_count, collection.data)
                } else {
                    self.drawCities(collection.total_count, collection.data)
                }
            },
            error: function(collection, resp) {
                Airstrip.renderFlash('error', "Something went wrong while loading map!")
            }
        })
    },

    drawCountries: function(total, data) {
        var self = this
        
        d3.json("/admin/data/mercator.json", function(countries) {
            self.feature = self.feature
                .data(countries.features)
                .enter().append("path")
                .attr("class", "feature")
                .attr("d", self.path)
                .style("fill", function(d) {
                    return self.scaleColor(data[d.properties.name], total, 2, 1.1, 1.5)
                })
                .on("mouseover", function() {
                    d3.select(this).attr("class", "feature hover")
                })
                .on("mouseout", function() {
                    d3.select(this).attr("class", "feature")
                })
        })
    },

    drawCities: function(total, data) {
        var self = this

        this.dots = this.svg
            .append('g')
            .attr('id', 'dots')
            .selectAll('.dot')

        d3.json("/admin/data/mercator.json", function(countries) {
            self.feature = self.feature
                .data(countries.features)
                .enter().append("path")
                .attr("class", "feature")
                .attr("d", self.path)

            var markers = d3.map(data).values().map(function(entry) {
                entry.coords = self.projection([ entry.lon, entry.lat ])
                return entry
            })
            
            self.dots.data(markers)
                .enter().append('circle')
                .attr('class', 'dot')
                .attr('cx', function(d) { return d.coords[0]; })
                .attr('cy', function(d) { return d.coords[1]; })
                .attr('r', function(d) {
                    return d.users_count / total * 80
                })
                .attr('fill', function(d) {
                    return self.scaleColor(d.users_count, total, 1.1, 2, 4)
                })
                .attr('opacity', function(d) {
                    return (5 + ((d.users_count / total) * 5)) / 10
                })
                .on("mouseover", function() {
                    d3.select(this)
                        .attr("class", "dot hover")
                        .attr("r", function(d) { return d.users_count / total * 120 })
                })
                .on("mouseout", function() {
                    d3.select(this)
                        .attr("class", "dot")
                        .attr("r", function(d) { return d.users_count / total * 80 })
                })
        })
    },

    scaleColor: function(val, total, r, g, b) {
        if (val) {
            scale = 255 - 255 * (val / total)
            return d3.rgb(scale / r, scale / g, scale / b)
        }
    },
})
