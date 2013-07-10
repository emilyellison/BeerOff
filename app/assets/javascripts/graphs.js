(function($) {
  $.fn.barFreqChart = function(beerData) {    
    
    // Find the element    
    var section = this[0];
  
    // Set width and height
    var svgWidth = 700;
    var svgHeight = 500;
    var svgPadding = 20;
  
    // Create the SVG Container
    var svgContainer = d3.select(section).append("svg")
                                         .attr("width", svgWidth)
                                         .attr("height", svgHeight);
  
    // Add rectangles for each data point                   
    var rectangles = svgContainer.selectAll("rect")
                                 .data(beerData)
                                 .enter()
                                 .append("rect");
  
    // Determine the max and min measures
    var maxMeasure = Math.max.apply(Math, beerData.map(function(o){return o.measure;}));
    var minMeasure = Math.min.apply(Math, beerData.map(function(o){return o.measure;}));
    var diffMeasure = maxMeasure - minMeasure + 1; 
  
    // Determine the width of the rectangles and their containers
    var rectanglePadding = 1;
    var containerWidth   = svgWidth / diffMeasure;
    var rectangleWidth   = svgWidth / diffMeasure - rectanglePadding;
    
    // Determine the height of the rectangles
    var maxRectangleFreq = Math.max.apply(Math, beerData.map(function(o){return o.freq;}));
    var rectangleHeightUnit = (svgHeight - svgPadding) / maxRectangleFreq;
      
    // Set the attributes for the rectangles
    var rectangleAttributes = rectangles
                                        // .attr("height", 0)
                                        // .transition()
                                        .attr("x", function(d, i) { return (d.measure - minMeasure) * containerWidth })                               
                                        .attr("y", function(d) { return svgHeight - (d.freq * rectangleHeightUnit) })
                                        .attr("width", function(d, i) { return rectangleWidth })
                                        .attr("height", function(d) {return (d.freq * rectangleHeightUnit) })
                                        .attr("fill", function(d) { return "rgb(" + d.freq + ", 0, 0)" }); 
                                        // .duration(200);
    
    // Add labels
    var labels = svgContainer.selectAll("text")
                             .data(beerData)
                             .enter()
                             .append("text");
                             
    // Format the labels                         
    var labelAttributes = labels.text(function (d) {return d.freq})
                                .attr("x", function(d, i) { return (d.measure - minMeasure) * containerWidth + containerWidth /2 })
                                .attr("y", function(d) { return svgHeight - (d.freq * rectangleHeightUnit) - 5 })
                                .attr("text-anchor", "middle")
                                .attr("font-family", "sans-serif")
                                .attr("font-weight", "bold")
                                .attr("font-size", "11px")
                                .attr("fill", "black");
                                
  } 
}(jQuery));