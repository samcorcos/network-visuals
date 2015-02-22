createMap = function() {
  var height = 600,
      width = 1000;

  var projection = d3.geo.albersUsa()
    .scale(1000)
    .translate([width / 2, height / 2]);


  var path = d3.geo.path()
    .projection(projection);


  var svg = d3.select("#concentration-map").append("svg")
    .attr("viewBox", "0 50 1000 550")
    .attr("preserveAspectRatio", "xMinYMin meet");

  ///////////////////////////////
  //Building Map
  ///////////////////////////////
  d3.json("us.json", function(error, us) {
    if (error) return console.error(error);

    svg.append("path")
      .datum(topojson.feature(us, us.objects.subunits))
      .attr("d", path);

    svg.selectAll(".subunit")
      .data(topojson.feature(us, us.objects.subunits).features)
      .enter().append("path")
      .attr("class", function(d) { return "subunit " + d.id; })
      //added id in above line to use as selector: ex US-NY
      .attr("d", path)
      .style('fill','#aaa')



    /////////Gives state boundary line
    svg.insert('path','.graticule')
      .datum(topojson.feature(us, us.objects.subunits,function(a, b) { return a !== b; }))
      .attr('class','state-boundary')
      .attr("d", path)
      .attr('stroke','#FFF')
      .style('fill','none')


    ///Populating stateHeat for use in heatmap below
    var locationConcentration = {};
    var paths = d3.selectAll('path')[0];
    paths.forEach(function(path){
      //Getting state abbreviation out of DOM
      var classString = path.className.animVal;
      var state = classString.slice(classString.length-2)
      locationConcentration[state] = 0;
    })

    People.find().fetch().forEach(function(person) {
      var thisState = d3.select('path[class*='+person.location+']');
      locationConcentration[person.location] += 1;
    })


      //////Added dot in the middle of the state
      /////////////Working with Bubbles

      svg.append("g")
        .attr("class", "bubble")
        .selectAll("circle")
        .data(topojson.feature(us, us.objects.subunits).features)
        .enter().append("circle")
          .attr("transform", function(d) { return "translate(" + path.centroid(d) + ")"; })
          .attr("r", function(d) {
            var tempArray = [];
            for (var num in locationConcentration) {
              tempArray.push(locationConcentration[num])
            }

            var radius = d3.scale.sqrt()
              .range([d3.min(tempArray), d3.max(tempArray)]);

            var abbrev = d.id.split('-').pop();

            return radius(locationConcentration[abbrev]);
          });

  })
}
