{Transform} = require 'stream'
_ = require 'lodash'

class SelectiveCollect extends Transform
  constructor: ->
    super objectMode: true

  _transform: (envelope, enc, next) =>
    {message, config, data} = envelope
    newData = _.defaults message, data

    @push _.pick newData, config.composeKeys
    @push null
    next()

module.exports = SelectiveCollect
