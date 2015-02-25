Router.configure
  layoutTemplate: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"

Router.map ->
  @route "home",
    path: "/"

  @route "about",
    path: "/about"

  @route 'grouped',
    path: '/grouped'
    waitOn: -> [
      Meteor.subscribe 'people'
    ]

  @route 'network',
    path: '/network'

  @route 'map',
    path: '/map'
    waitOn: -> [
      Meteor.subscribe 'people'
    ]
    
  return
