ReturnValue = require 'nanocyte-component-return-value'
_ = require 'lodash'

class SelectiveCollect extends ReturnValue
  onEnvelope: (envelope) =>
    {config, data} = envelope

    compose = _.pick config.compose, (value) => value?
    newData = _.defaults {}, compose, data
    return _.pick newData, _.keys(config.compose)

module.exports = SelectiveCollect
