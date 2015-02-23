Template.map.rendered = ->
  createMap (err, res) ->
    throw err if err

# Template.map.events
#   'click circle': (e,t) ->
#     console.log e
