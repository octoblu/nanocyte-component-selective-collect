ReturnValue = require 'nanocyte-component-return-value'
_ = require 'lodash'

class SelectiveCollect extends ReturnValue
  onEnvelope: (envelope) =>
    {config, data} = envelope

    result = {}

    composeData = @_convert config.compose

    _.each composeData, ([key, value]) =>
      value ?= _.get data, key
      _.set result, key, value if value?

    return result

  _convert: (data) =>
    return data if _.isArray data
    _.pairs data

module.exports = SelectiveCollect
