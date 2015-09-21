SelectiveCollect = require '../src/selective-collect'

describe 'SelectiveCollect', ->
  beforeEach ->
    @sut = new SelectiveCollect

  describe 'when written to and read from', ->
    beforeEach (done) ->
      @sut.on 'end', done

      @sut.write
        message: {foo: 'bar', stairs: 'the mall'}
        config: {composeKeys: ['foo']}
        data: {}

      @things = []
      @sut.on 'readable', =>
        while thing = @sut.read()
          @things.push thing

    it 'should have emitted the message', ->
      expect(@things).to.deep.contain {foo: 'bar'}

  describe 'when written to again', ->
    beforeEach ->
      @sut.write
        message: {glass: 'mirror', stairs: 'the mall'}
        config: {composeKeys: ['glass', 'stairs']}
        data: {}

    it 'should be readable', ->
      expect(@sut.read()).to.deep.equal {glass: 'mirror', stairs: 'the mall'}

  describe 'when written to while it already has data', ->
    beforeEach ->
      @sut.write
        message: {stairs: 'the mall'}
        config:  {composeKeys: ['glass', 'stairs']}
        data:    {glass: 'mirror'}

    it 'should be readable', ->
      expect(@sut.read()).to.deep.equal {glass: 'mirror', stairs: 'the mall'}

  describe 'when written to while it already has data it shouldnt', ->
    beforeEach ->
      @sut.write
        message: {stairs: 'the mall'}
        config:  {composeKeys: ['stairs']}
        data:    {glass: 'mirror'}

    it 'should be readable', ->
      expect(@sut.read()).to.deep.equal {stairs: 'the mall'}
