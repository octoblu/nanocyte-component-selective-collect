SelectiveCollect = require '../src/selective-collect'

describe 'SelectiveCollect', ->
  beforeEach ->
    @sut = new SelectiveCollect

  describe 'when given more than we collect', ->
    beforeEach ->
      @result = @sut.onEnvelope
        message: {foo: 'bar', stairs: 'the mall'}
        config: {composeKeys: ['foo']}
        data: {}

    it 'should return the message', ->
      expect(@result).to.deep.contain {foo: 'bar'}

  describe 'when written to again', ->
    beforeEach ->
      @result = @sut.onEnvelope
        message: {glass: 'mirror', stairs: 'the mall'}
        config: {composeKeys: ['glass', 'stairs']}
        data: {}

    it 'should be readable', ->
      expect(@result).to.deep.equal {glass: 'mirror', stairs: 'the mall'}

  describe 'when written to while it already has data', ->
    beforeEach ->
      @result = @sut.onEnvelope
        message: {stairs: 'the mall'}
        config:  {composeKeys: ['glass', 'stairs']}
        data:    {glass: 'mirror'}

    it 'should be readable', ->
      expect(@result).to.deep.equal {glass: 'mirror', stairs: 'the mall'}

  describe 'when written to while it already has data it shouldnt', ->
    beforeEach ->
      @result = @sut.onEnvelope
        message: {stairs: 'the mall'}
        config:  {composeKeys: ['stairs']}
        data:    {glass: 'mirror'}

    it 'should be readable', ->
      expect(@result).to.deep.equal {stairs: 'the mall'}
