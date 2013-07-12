(function($) {
  $.fn.scatterPlot = function(data) {    
    
    // Find the data
    var beerData = data['data'];
    var xLabel = data['x_label'];
    var yLabel = data['y_label'];
    
    // Find the element    
    var section = this[0];
      
    // Set width and height
    var svgWidth = 740;
    var svgHeight = 600;
    var svgPadding = 50;
      
    // Create the SVG Container
    var svg = d3.select(section).append("svg").attr("width", svgWidth).attr("height", svgHeight);
      
    // Create the x-axis
    var xMax   = d3.max($.map(beerData, function(d) { return d.x; }));
    var xMin   = d3.min($.map(beerData, function(d) { return d.x; }));
    var xUnit  = xMax / 10;
    var xScale = d3.scale.linear().domain([0, xMax + xUnit]).range([0, svgWidth]);
    var xAxis  = d3.svg.axis().scale(xScale).orient("bottom").ticks(10);
    svg.append("g").attr('class', 'axis').attr("transform", "translate(" + svgPadding + "," + (svgHeight - svgPadding) + ")").call(xAxis);
    
    // Add x-axis label
    svg.append("text")
        .attr("class", "x-label")
        .attr("text-anchor", "end")
        .attr("x", svgWidth )
        .attr("y", svgHeight - 5)
        .attr("font-size", "16px")
        .text(xLabel);
      
    // Create the y-axis
    var yMax   = d3.max($.map(beerData, function(d) { return d.y; }));
    var yMin   = d3.min($.map(beerData, function(d) { return d.y; }));
    var yUnit  = yMax / 10;
    var yScale = d3.scale.linear().domain([0, yMax + yUnit]).range([ svgHeight - svgPadding, 0 ]);
    var yAxis  = d3.svg.axis().scale(yScale).orient("left").ticks(10);
    svg.append("g").attr('class', 'axis').attr("transform", "translate(" + svgPadding + ", 0)").call(yAxis);
    
    // Add y-axis label
    svg.append("text")
        .attr("class", "y-label")
        .attr("text-anchor", "end")
        .attr("y", 12)
        .attr("transform", "rotate(-90)")
        .attr("font-size", "16px")
        .text(yLabel);
    
    // Add groups for each data point
    var groups = svg.selectAll(".node").data(beerData).enter().append("g");
      
    // Add circles to each group
    var circles = groups.append("circle");
    
    // Set circle color and radius
    var freqMax = d3.max($.map(beerData, function(d) { return d.freq; }));
    function circleColor(y) { return Math.round((140 - 40)/(freqMax))*y + 40};
    function circleRadius(y) { return y * 3 };
    
    // Set circle attributes
    var circleAttributes = circles.attr("r", 0)
                                  .transition()
                                  .attr("cx", function(d) { return xScale(d.x) + svgPadding })
                                  .attr("cy", function(d) { return yScale(d.y) })
                                  .attr("r", function(d) { return circleRadius(d.freq) })
                                  .attr("fill", function(d) { return "rgb(" + circleColor(d.freq) + ",0,0)" } )
                                  .duration(1600);
      
    // Add labels to each group
    var labels = groups.append('text');
    // 
    // Add label attributes to labels
    var labelAttributes = labels.text(function(d) { return d.freq })
                                .attr("x", function(d, i) { return xScale(d.x) + svgPadding })
                                .attr("y", function (d, i) { return yScale(d.y) - 15})
                                .attr("text-anchor", "middle")
                                .classed("hidden", true);
    
    // Only show labels on hover
    groups.on("mouseover", function() { 
      d3.select(this).selectAll('circle').style('opacity', 0.8); 
      d3.select(this).selectAll('text').classed("hidden", false); 
    });
    
    groups.on("mouseleave", function() { 
      d3.select(this).selectAll('circle').style('opacity', 1); 
      d3.select(this).selectAll('text').classed("hidden", true); 
    });
       
  } 
}(jQuery));