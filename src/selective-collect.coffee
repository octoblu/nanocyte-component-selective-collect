ReturnValue = require 'nanocyte-component-return-value'
_ = require 'lodash'

class SelectiveCollect extends ReturnValue
  onEnvelope: (envelope) =>
    {config, data} = envelope

    result = {}
    _.each config.compose, (value, key) =>
      value ?= _.get data, key
      _.set result, key, value if value?

    return result

module.exports = SelectiveCollect
