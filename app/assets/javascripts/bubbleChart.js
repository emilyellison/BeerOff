(function($) {
  $.fn.bubbleChart = function(data) {    
    
    beerData = data['data']
    
    var diameter = 740,
        format = d3.format(",d"),
        color = d3.scale.category20c();

    var bubble = d3.layout.pack()
        .sort(null)
        .size([diameter, diameter])
        .padding(35);

    var svg = d3.select(".graph").append("svg")
        .attr("width", diameter)
        .attr("height", diameter)
        .attr("class", "bubble");

    var node = svg.selectAll(".node")
        .data(bubble.nodes(classes(beerData))
        .filter(function(d) { return !d.children; }))
        .enter()
        .append("g")
        .attr("class", "node")
        .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

      node.append("title")
          .text(function(d) { return d.className + ': '+  d.value; });

      node.append("circle")
          .attr("r", 0)
          .transition()
          .attr("r", function(d) { return d.r; })
          .attr("class", function(d) { return d.className.toLowerCase();})
          .duration(1000);

      node.append("text")
          .attr("dy", ".3em")
          .style("text-anchor", "middle")
          .attr("class", function(d) { return "bubble " + d.className.toLowerCase();})
          .text(function(d) { return d.className; });
          
    function classes(root) {
      var classes = [];

      function recurse(name, node) {
        if (node.children) node.children.forEach(function(child) { recurse(node.name, child); });
        else classes.push({packageName: name, className: node.name, value: node.size});
      }

      recurse(null, root);
      return {children: classes};
    }
          
    d3.select(self.frameElement).style("height", diameter + "px");

  } 
}(jQuery));