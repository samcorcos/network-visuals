@createMap = ->
  height = 600
  width = 1000

  projection = d3.geo.albersUsa()
    .scale(1000)
    .translate([
      width / 2
      height / 2
    ])

  path = d3.geo.path()
    .projection(projection)

  svg = d3.select('#concentration-map').append('svg')
    .attr('viewBox', '0 50 1000 550')
    .attr('preserveAspectRatio', 'xMinYMin meet')

  ###
  Building Map
  ###

  d3.json 'us.json', (err, us) ->
    throw err if err

    svg.append('path')
      .datum(topojson.feature(us, us.objects.subunits).features)
      .enter().append('path')
      .attr('class', (d) ->
        'subunit' + d.id
      ).attr('d', path)
      .style('fill', '#aaa')

    # Gives state boundary lines
    svg.insert('path', '.graticule')
      .datum(topojson.feature(us, us.objects.subunits, (a,b) ->
        a != b
      )).attr('class', 'state-boundary')
      .attr('d', path)
      .attr('stroke', '#fff')
      .style('fill', 'none')

    # Populating state heat for use in heatmap
    locationConcentration = {}
    paths = d3.selectAll('path')[0]
    paths.forEach (path) ->
      # Getting state abbreviation out of DOM
      classString = path.className.animVal
      state = classString.slice(classString.length - 2)
      locationConcentration[state] = 0

    d3.json 'locations.json', (err, data) ->
      throw err if err

      locations = data.locations
      locations.forEach (location) ->
        state = location.state
        thisState = d3.select("path[class*=#{state}]")
        locationConcentration[state] += 1

    # Adding dot in the middle of the state
    # Working with bubbles

    svg.append('g')
      .attr('class', 'bubble')
      .selectAll('circle')
      .data(topojson.feature(us, us.objects.subunits).features)
      .enter().append('circle')
        .attr('transform', (d) ->
          "translate(#{path.centroid(d)})"
        ).attr('r', (d) ->
          tempArray = []
          for num in locationConcentration
            tempArray.push(locationConcentration[num])

          radius = d3.scale.sqrt()
            .range([
              d3.min(tempArray)
              d3.max(tempArray)
            ])

          abbrev = d.id.split('-').pop()

          radius(locationConcentration(abbrev))

        )
