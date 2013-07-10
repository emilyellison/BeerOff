(function($) {
  $.fn.barFreqChart = function(beerData, xLabel, yLabel) {    
    
    // Find the element    
    var section = this[0];
  
    // Set width and height
    var svgWidth = 700;
    var svgHeight = 550;
    var svgPadding = 40;
  
    // Create the SVG Container
    var svg = d3.select(section).append("svg").attr("width", svgWidth).attr("height", svgHeight);
  
    // Create the x-axis
    var xMax   = d3.max($.map(beerData, function(d) { return d.measure; }));
    var xMin   = d3.min($.map(beerData, function(d) { return d.measure; }));
    var xUnit  = xMax / 10;
    var xScale = d3.scale.linear().domain([0, xMax + xUnit]).range([0, svgWidth]);
    var xAxis  = d3.svg.axis().scale(xScale).orient("bottom").ticks(10);
    svg.append("g").attr('class', 'axis').attr("transform", "translate(" + svgPadding + "," + (svgHeight - svgPadding) + ")").call(xAxis);
    
    // Add x-axis label
    svg.append("text.label")
        .attr("class", "x-label")
        .attr("text-anchor", "end")
        .attr("x", svgWidth )
        .attr("y", svgHeight - 5)
        .text(xLabel);
  
    // Create the y-axis
    var yMax   = d3.max($.map(beerData, function(d) { return d.freq; }));
    var yMin   = d3.min($.map(beerData, function(d) { return d.freq; }));
    var yScale = d3.scale.linear().domain([0, yMax]).range([ svgHeight - svgPadding, 0]);
    var yAxis  = d3.svg.axis().scale(yScale).orient("left").ticks(10);
    svg.append("g").attr('class', 'axis').attr("transform", "translate(" + svgPadding + ", 0)").call(yAxis);
    
    // Add y-axis label
    svg.append("text.label")
        .attr("class", "y-label")
        .attr("text-anchor", "end")
        .attr("y", 12)
        .attr("transform", "rotate(-90)")
        .text(yLabel);
  
    // Set rectangle width and color
    rectangleWidth = (svgWidth - svgPadding) / (xMax + xUnit);
    function rectangleColor(freq) { return Math.round((140 - 40)/(yMax - yMin))*freq + 40};
  
    // Add rectangles for each data point                   
    var rectangles = svg.selectAll("rect").data(beerData).enter().append("rect");
    
    // Set rectangle attributes
    var rectangleAttributes = rectangles.attr("height", 0)
                                        .attr("y", svgHeight - svgPadding)
                                        .attr("fill", function(d) { return "rgb(40,0,0)" })
                                        .transition()
                                        .delay(function(d, i) { return i * 200 })
                                        .duration(800)
                                        .attr("x", function(d, i) { return xScale(d.measure) + svgPadding - rectangleWidth / 2 })
                                        .attr("y", function(d, i) { return  yScale(d.freq)})
                                        .attr("width", rectangleWidth)
                                        .attr("height", function (d, i) { return svgHeight - svgPadding - yScale(d.freq) })
                                        .attr("fill", function(d) { return "rgb(" + rectangleColor(d.freq) + ",0,0)" });

  } 
}(jQuery));