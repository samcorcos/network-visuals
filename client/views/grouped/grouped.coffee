Template.grouped.rendered = ->
	$('ul.tabs').tabs()

	nodes = People.find().fetch()
	defStart = 'occupation'
	Session.setDefault 'tickString', defStart
	Session.setDefault 'category', defStart
	Session.setDefault 'group', []

	document.getElementById("gender").addEventListener "click", (e) -> # TODO show how to make these as Template.events rather than event listeners
		category = _.uniq _.pluck(nodes, 'gender')
		Session.set 'category', 'gender'
		Session.set 'tickString', "gender"
		Session.set 'group', []
		force.start()

	document.getElementById("occupation").addEventListener "click", (e) ->
		category = _.uniq _.pluck(nodes, 'occupation')
		Session.set 'category', 'occupation'
		Session.set 'tickString', "occupation"
		Session.set 'group', []
		force.start()

	document.getElementById("status").addEventListener "click", (e) ->
		category = _.uniq _.pluck(nodes, 'marital_status')
		Session.set 'category', 'Marital Status'
		Session.set 'group', []
		Session.set 'tickString', "marital_status"
		force.start()

	width = 800 # TODO is there a way to turn these into functions relative to view width? There will eventually be as many as 400-500 people
	height = 200

	fill = d3.scale.category20()
	foci = {}

	categorySwitch = (tickString) ->
		categories = _.uniq _.pluck(nodes, tickString)
		numFoci = categories.length
		foci = {}

		categories.forEach (d, i) ->
			spacing = width/numFoci
			index = i*1.5;
			o = {x: index * spacing, y: height/2}
			foci[d] = o

	force = d3.layout.force()
		.nodes nodes
		.size [width, height]
		.on 'tick', (e) ->
			tickString = Session.get 'tickString'
			categorySwitch(tickString)
			k = 0.1 * e.alpha
			nodes.forEach (o, i) ->
				o.y += (foci[o[tickString]].y - o.y) * k
				o.x += (foci[o[tickString]].x - o.x) * k
			node
				.attr 'fill', (d) -> fill(d[tickString])
				.attr 'cx', (d) -> d.x
				.attr 'cy', (d) -> d.y
			text
				.attr 'x', (d) -> d.x
				.attr 'y', (d) -> d.y
		.start()

	svg = d3.select '#group-force'
		.append 'svg'
		.attr 'width', width
		.attr 'height', height

	nodeGroup = svg.selectAll 'node'
		.data nodes
		.enter()
		.append 'g'
		.attr 'class', 'node-group'

	node = nodeGroup.append 'circle'
		.attr 'class', 'node'
		.attr 'cx', (d) -> d.x
		.attr 'cy', (d) -> d.y
		.attr 'r', 8
		.call force.drag
		.on 'click', ->
			display = []
			currentCategory = Session.get 'tickString'
			categorySpec = d3.select(@).datum()[currentCategory]
			nodes.forEach (d, i) ->
				if d[currentCategory] is categorySpec then display.push(d)
			Session.set 'category', categorySpec
			Session.set 'group', display
		.on 'mouseover', ->
			d3.select(@).style 'opacity', 0.6
		.on 'mouseout', ->
			d3.select(@).style 'opacity', 1


	text = nodeGroup.append 'text'
		.attr 'class', 'data'
		.attr 'fill', 'black'
		.attr 'font-size', '20px'
		.attr 'x', (d) -> d.x
		.attr 'y', (d) -> d.y
		.style 'display', 'none'
		.text (d) -> d.name

	svg.style 'opacity', 1e-6
		.transition()
		.duration(1000)
		.style 'opacity', 1

	### Tooltips ###
	tooltip = d3.select 'body'
		.append 'div'
		.style 'position', 'absolute'
		.style 'padding', '0 10px'
		.style 'background', 'black'
		.style 'color', 'white'
		.style 'opacity', 0

	d3.selectAll 'circle'
		.on 'mouseover', (d) ->
			console.log d

			tooltip.transition()
			.style 'opacity', 0.9

			tooltip.html d.name
			.style('left', d3.event.pageX + 10 + 'px')
			.style('top', d3.event.pageY - 10 + 'px')

		.on 'mouseout', (d) ->
			tooltip.transition().duration(500)
			.style 'opacity', 0

	### End Tooltips ###





Template.grouped.helpers
	category: ->
		cat = Session.get 'category'

	sort: ->
		Session.get 'tickString'

	group: ->
		Session.get 'group'
