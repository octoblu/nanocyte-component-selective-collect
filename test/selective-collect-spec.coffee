SelectiveCollect = require '../src/selective-collect'

describe 'SelectiveCollect', ->
  beforeEach ->
    @sut = new SelectiveCollect

  describe 'when given more than we collect', ->
    beforeEach ->
      @result = @sut.onEnvelope
        config: {compose: {'foo': 'bar'}}
        data: {}

    it 'should return the message', ->
      expect(@result).to.deep.contain {foo: 'bar'}

  describe 'when written to again', ->
    beforeEach ->
      @result = @sut.onEnvelope
        config: {compose: {'glass': 'mirror', 'stairs': 'the mall'}}
        data: {}

    it 'should return all the keys in message', ->
      expect(@result).to.deep.equal {glass: 'mirror', stairs: 'the mall'}

  describe 'when written to while it already has non-overlapping data', ->
    beforeEach ->
      @result = @sut.onEnvelope
        config:  {compose: {'glass': null, 'stairs': 'the mall'}}
        data:    {glass: 'mirror'}

    it 'should merge the message with the data and whitelist the result', ->
      expect(@result).to.deep.equal {glass: 'mirror', stairs: 'the mall'}

  describe 'when written to while it already has overlapping data', ->
    beforeEach ->
      @result = @sut.onEnvelope
        config:  {compose: {'glass': 'window', 'stairs': 'the mall'}}
        data:    {glass: 'mirror'}

    it 'should overwrite the stored data with what was new', ->
      expect(@result).to.deep.equal {glass: 'window', stairs: 'the mall'}

  describe 'when written to while it already has data it shouldnt', ->
    beforeEach ->
      @result = @sut.onEnvelope
        config:  {compose: {'stairs': 'the mall'}}
        data:    {glass: 'mirror'}

    it 'should return the message an ignore non-whitelisted keys', ->
      expect(@result).to.deep.equal {stairs: 'the mall'}
