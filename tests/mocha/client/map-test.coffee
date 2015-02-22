if !(typeof MochaWeb == 'undefined')
  MochaWeb.testOnly ->

    describe 'D3 Map', ->

      describe 'createMap function', ->
        it 'should make sure that the function for creating the map is being called propertly and does not error', ->
          createMap()

      describe 'createMap collections', ->
        it 'should not work unless it has access to the People collection', ->
          chai.expect(People.find().count()).to.be.above(0)

      return # return for D3 Map
    return # return for MochaWeb
