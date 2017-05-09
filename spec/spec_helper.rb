ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require('sinatra/activerecord')
require('question')
require('survey')
require('respondant')

RSpec.configure do |config|
  config.after(:each) do
    Question.all().each() do |question|
      question.destroy()
    end
    Survey.all().each() do |survey|
      survey.destroy()
    end
    Respondant.all().each() do |respondant|
      respondant.destroy()
    end
  end
end
