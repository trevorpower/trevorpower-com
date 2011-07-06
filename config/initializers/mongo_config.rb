require 'mm-multi-parameter-attributes'

MongoMapper::Document.plugin(MongoMapper::Plugins::MultiParameterAttributes)
#MongoMapper::Document.append_inclusions(MongoMapper::Plugins::MultiParameterAttributes)
