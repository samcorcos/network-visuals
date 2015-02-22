@People = new Mongo.Collection 'people'

if Meteor.isServer
  Meteor.publish 'people', ->
    People.find()

  People.allow
    insert: (userid, doc) ->
      true

    update: (userId, docs, fields, modifier) ->
      true

    remove: (userId, docs) ->
      true

  People.deny
    insert: (userId, doc) ->

    update: (userId, docs, fields, modifier) ->

    remove: (userId, docs) ->


if Meteor.isClient
  Meteor.subscribe 'people'
