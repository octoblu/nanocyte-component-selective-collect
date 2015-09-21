SelectiveCollect = require '../src/selective-collect'

describe 'SelectiveCollect', ->
  beforeEach ->
    @sut = new SelectiveCollect

  describe 'when given more than we collect', ->
    beforeEach ->
      @result = @sut.onEnvelope
        message: {foo: 'bar', stairs: 'the mall'}
        config: {compose: {'foo': 'foo'}}
        data: {}

    it 'should return the message', ->
      expect(@result).to.deep.contain {foo: 'bar'}

  describe 'when written to again', ->
    beforeEach ->
      @result = @sut.onEnvelope
        message: {glass: 'mirror', stairs: 'the mall'}
        config: {compose: {'glass': 'glass', 'stairs': 'stairs'}}
        data: {}

    it 'should return all the keys in message', ->
      expect(@result).to.deep.equal {glass: 'mirror', stairs: 'the mall'}

  describe 'when written to while it already has data', ->
    beforeEach ->
      @result = @sut.onEnvelope
        message: {stairs: 'the mall'}
        config:  {compose: {'glass': 'glass', 'stairs': 'stairs'}}
        data:    {glass: 'mirror'}

    it 'should merge the message with the data and whitelist the result', ->
      expect(@result).to.deep.equal {glass: 'mirror', stairs: 'the mall'}

  describe 'when written to while it already has data it shouldnt', ->
    beforeEach ->
      @result = @sut.onEnvelope
        message: {stairs: 'the mall'}
        config:  {compose: {'stairs': 'stairs'}}
        data:    {glass: 'mirror'}

    it 'should return the message an ignore non-whitelisted keys', ->
      expect(@result).to.deep.equal {stairs: 'the mall'}
