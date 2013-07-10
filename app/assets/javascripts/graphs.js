(function($) {
  $.fn.barFreqChart = function(beerData) {
    var section = this[0];

    // Set width and height
    var svgWidth = 700;
    var svgHeight = 500;
    var svgPadding = 10;

    // Create the SVG Container
    var svgContainer = d3.select(section).append("svg")
                                      .attr("width", svgWidth)
                                      .attr("height", svgHeight);

    // Add rectangles for each data point                   
    var rectangles = svgContainer.selectAll("rect")
                                 .data(beerData)
                                 .enter()
                                 .append("rect");

    // Determine the width of the rectangles and their containers
    var rectanglePadding = 1;
    var containerWidth     = svgWidth / beerData.length;
    var rectangleWidth   = svgWidth / beerData.length - rectanglePadding;
    
    // Determine the height of the rectangles
    var maxRectangleFreq = Math.max.apply(Math, beerData.map(function(o){return o.freq;}))
    var rectangleHeightUnit = (svgHeight - svgPadding) / maxRectangleFreq;

    // Set the attributes for the rectangles
    var rectangleAttributes = rectangles
                                        // .attr("height", 0)
                                        // .transition()
                                        .attr("x", function(d, i) { return i * containerWidth })                               
                                        .attr("y", function(d) { return svgHeight - (d.freq * rectangleHeightUnit) })
                                        .attr("width", function(d, i) { return rectangleWidth })
                                        .attr("height", function(d) {return (d.freq * rectangleHeightUnit) })
                                        .attr("fill", function(d) { return "rgb(" + (30 + d.freq * rectangleHeightUnit) + ", 40, 30)" }); 
                                        // .duration(200);
  } 
}(jQuery));