/**
 * Public: This view renders world map graphs with selected user
 * locations grouped by nearby cities or countries. 
 */
Desant.Admin.LocationsMapView = Backbone.View.extend({
    el: '.extras',
    template: '<div id="map"><svg></svg></div>',

    render: function() {
        this.$el.html(this.template)
        this.$map = this.$('#map')

        $('a.nav.locations').addClass('current')
        
        this.buildGraph()
            .load(this.options.group)

        return this
    },

    /**
     * Internal: Initializes graph settings and returns itself.
     */
    buildGraph: function() {
        this.margin = { top: 120, right: 0, bottom: 0, left: 0 }
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

    /**
     * Internal: Loads data for the specified group and renders a neat
     * graph representation for them.
     *
     * group - A String group to be loaded (either 'cities' or 'countries')
     *
     * Returns itself.
     */
    load: function(group) {
        var self = this
        
        mercatorData = new Desant.Admin.MercatorData({ group: group })
        mercatorData.fetch({
            success: function(collection, resp) {
                if (group == 'countries') {
                    self.drawCountries(collection.total_count, collection.data)
                } else {
                    self.drawCities(collection.total_count, collection.data)
                }
            },
            error: function(collection, resp) {
                Desant.renderFlash('error', "Something went wrong while loading map!")
            }
        })

        return this
    },

    /**
     * Internal: Draws a world map with countries data.
     *
     * total - A Number total count of items.
     * data  - An Array with data to be displayed.
     *
     * Returns itself.
     */
    drawCountries: function(total, data) {
        var self = this
        
        d3.json("/admin/data/mercator.json", function(countries) {
            self.feature = self.feature
                .data(countries.features)
                .enter().append("path")
                .attr("class", "feature")
                .attr("d", self.path)
                .style("fill", function(d) {
                    return self.scaleColor(data[d.properties.name], total, 1.4, 1.1, 1.6)
                })
                .on("mouseover", function() {
                    d3.select(this).attr("class", "feature hover")
                })
                .on("mouseout", function() {
                    d3.select(this).attr("class", "feature")
                })
        })

        return this;
    },

    /**
     * Internal: Draws a world map with cities data.
     *
     * total - A Number total count of items.
     * data  - An Array with data to be displayed.
     *
     * Returns itself.
     */
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

            circleRadius = function(d) {
                return 3 + ((d.users_count / total) * 15)
            }
            
            self.dots.data(markers)
                .enter().append('circle')
                .attr('class', 'dot')
                .attr('cx', function(d) { return d.coords[0]; })
                .attr('cy', function(d) { return d.coords[1]; })
                .attr('r', circleRadius)
                .attr('fill', function(d) {
                    return self.scaleColor(d.users_count, total, 1.1, 2, 4)
                })
                .attr('opacity', function(d) {
                    return (5 + ((d.users_count / total) * 5)) / 10
                })
                .on("mouseover", function() {
                    d3.select(this)
                        .attr("class", "dot hover")
                        .attr('r', function(d) { return circleRadius(d) * 1.5 })
                })
                .on("mouseout", function() {
                    d3.select(this)
                        .attr("class", "dot")
                        .attr("r", circleRadius)
                })
        })

        return this
    },

    /**
     * Intenral: A color helper - gets item value and maximum value
     * and build a color with appropriate intensity for them. Another
     * params indicate initial intensity of red, green and blue
     * channels.
     *
     * val   - A Number value to be represented.
     * total - A Number maximum value.
     * r     - Initial red channel value intensity.
     * g     - Initial green channel value intensity.
     * b     - Initial blue channel value intensity.
     *
     * Example
     *
     *   this.scaleColor(val, total, 2, 1.1, 1.5)
     *
     * This will use a bluish-green (cyan-green) scale of the colors
     * to indicate value to total relation. The biggest color channel
     * intensity defined, the brighter color is.
     *
     * Returns d3's rgb color object.
     */
    scaleColor: function(val, total, r, g, b) {
        if (val) {
            scale = 255 - 100 * (val / total)
            return d3.rgb(scale / r, scale / g, scale / b)
        }
    },
})
