require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

post('/surveys') do
  name = params.fetch("name")
  @survey = Survey.create({:name => name})
  @surveys = Survey.all
  erb(:index)
end

get("/surveys/:id") do
  @survey = Survey.find(params.fetch("id").to_i())
  erb(:survey)
end

post("/questions") do
  description = params.fetch("description")
  survey_id = params.fetch("survey_id").to_i()
  question = Question.create({:description => description, :survey_id => survey_id})
  @survey = Survey.find(survey_id)
  erb(:survey)

end
