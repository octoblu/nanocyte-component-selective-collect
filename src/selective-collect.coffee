ReturnValue = require 'nanocyte-component-return-value'
_ = require 'lodash'

class SelectiveCollect extends ReturnValue
  onEnvelope: (envelope) =>
    {message, config, data} = envelope
    newData = _.defaults message, data

    return _.pick newData, _.keys(config.compose)

module.exports = SelectiveCollect
