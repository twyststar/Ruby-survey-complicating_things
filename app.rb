require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload('lib/**/*.rb')
require('./lib/question')
require('./lib/survey')
require('./lib/respondant')
require('pry')
require('pg')

get('/') do
  @surveys = Survey.all()

  erb(:landing)
end

get('/survey_home') do
  @surveys = Survey.all()
  erb(:survey_home)
end

post('/surveys') do
  @surveys = Survey.all()
  survey_name = params.fetch('survey_name')
  new_survey = Survey.create({:name => survey_name})
  erb(:survey_home)
end

get('/surveys/:id/questions') do
  @survey = Survey.find(params.fetch("id").to_i())
  erb(:questions)
end

patch('/surveys/:id/questions') do
  @questions = Question.all()
  @survey = Survey.find(params.fetch("id").to_i())
  name = params.fetch("name")
  @survey.update({:name => name})
  erb(:questions)
end

delete('/surveys/:id/questions') do
  @questions = Question.all()
  @survey = Survey.find(params.fetch("id").to_i())
  @survey.delete()
  @surveys = Survey.all()
  erb(:survey_home)
end

post('/surveys/:id/questions') do
  q_text = params.fetch('q_text')
  survey_id = params.fetch('survey_id').to_i()
  @survey = Survey.find(survey_id)
  new_question = Question.create({:q_text => q_text, :survey_id => survey_id})
  erb(:questions)
end

post('/surveys_mult/:id/questions') do
  q_text = params.fetch('q_text')
  survey_id = params.fetch('survey_id').to_i()
  opt_1 = params.fetch('opt_1')
  opt_2 = params.fetch('opt_2')
  opt_3 = params.fetch('opt_3')
  @survey = Survey.find(survey_id)
  new_question = Question.create({:q_text => q_text, :survey_id => survey_id, :opt_1 => opt_1, :opt_2 => opt_2, :opt_3 => opt_3})
  erb(:questions)
end

patch('/surveys/:id/questions/:q_id') do
  @questions = Question.all()
  @survey = Survey.find(params.fetch("id").to_i())
  @question = Question.find(params.fetch("q_id").to_i())
  survey_id = @survey.id()
  q_text = params.fetch("q_text")
  if @question.opt_1?
    opt_1 = params.fetch('opt_1')
    opt_2 = params.fetch('opt_2')
    opt_3 = params.fetch('opt_3')
    @question.update({:q_text => q_text, :survey_id => survey_id, :opt_1 => opt_1, :opt_2 => opt_2, :opt_3 => opt_3})
    erb(:questions)
  else
    @question.update({:q_text => q_text})
  erb(:questions)
  end
end

delete('/surveys/:id/questions/:q_id') do
  @survey = Survey.find(params.fetch("id").to_i())
  @question = Question.find(params.fetch("q_id").to_i())
  @question.delete()
  @questions = Question.all()
  erb(:questions)
end

get('/surveys/:id/questions/:q_id/edit') do
  @survey = Survey.find(params.fetch("id").to_i())
  @question = Question.find(params.fetch("q_id").to_i())
  erb(:question_edit)
end


post('/quiz_form') do
  name = params.fetch('user_name')
  survey_id = params.fetch('survey_choice').to_i()
  @respondant = Respondant.create({:user_name => name, :survey_id => survey_id})
  @survey = Survey.find(survey_id)
  @count = 0
  erb(:quiz_home)
end

# get('/respondants/:respondant_id/:survey_id/:count') do
#   respondant_id = params.fetch('respondant_id').to_i()
#   old_name = Respondant.find(respondant_id).user_name()
#   survey_id = params.fetch('survey_id').to_i()
#   count = params.fetch('count').to_i()
#
#
#   @count = count + 1
#   @survey = Survey.find(survey_id)
#   erb(:quiz_home)
# end

post('/respondants/:respondant_id/:survey_id/:count') do
  respondant_id = params.fetch('respondant_id').to_i()
  old_name = Respondant.find(respondant_id).user_name()
  survey_id = params.fetch('survey_id').to_i()
  count = params.fetch('count').to_i()
  question_id = params.fetch('question_id').to_i()
  answer = params.fetch('answer')
  @count = count + 1
  @respondant = Respondant.create({:user_name => old_name, :survey_id => survey_id, :question_id => question_id, :answers => answer})
  @survey = Survey.find(survey_id)
  erb(:quiz_home)
end
