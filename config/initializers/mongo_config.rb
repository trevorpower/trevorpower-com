require 'mm-multi-parameter-attributes'

if ENV['MONGOHQ_URL']
  MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
  MongoMapper.connect(RAILS_ENV)
else
  MongoMapper.database = "content-#{Rails.env}"
end
MongoMapper::Document.append_inclusions(MongoMapper::Plugins::MultiParameterAttributes)
