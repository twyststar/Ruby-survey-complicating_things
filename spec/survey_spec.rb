require('spec_helper')

describe(Survey) do
  describe("#questions") do
    it("will associate a question with a designated survey") do
      test_survey = Survey.create({:name => "Kitten preference"})
      test_question = Question.create({:q_text => "Do you prefer a black or white kitten?", :survey_id => test_survey.id()})
      expect(test_survey.questions()).to(eq([test_question]))
    end
  end

  describe("#questions") do
    it("will associate multiple question with a designated survey") do
      test_survey = Survey.create({:name => "Kitten preference"})
      test_question1 = Question.create({:q_text => "Do you prefer a black or white kitten?", :survey_id => test_survey.id()})
      test_question2 = Question.create({:q_text => "Do you prefer a calico or siamese kitten?", :survey_id => test_survey.id()})
      expect(test_survey.questions()).to(eq([test_question1, test_question2]))
    end
  end
  describe("#questions") do
    it("will grab question by index") do
      test_survey = Survey.create({:name => "Kitten preference"})
      test_question1 = Question.create({:q_text => "Do you prefer a black or white kitten?", :survey_id => test_survey.id()})
      test_question2 = Question.create({:q_text => "Do you prefer a calico or siamese kitten?", :survey_id => test_survey.id()})
      expect(test_survey.questions[1].id()).to(eq(test_question2.id()))
    end
  end

  it("validates presence of description") do
    @survey = Survey.new({:name => ""})
    expect(@survey.save()).to(eq(false))
  end

  it("capitalizes the first letters") do
    @survey = Survey.create({:name => "finagle the buffalo"})
    expect(@survey.name()).to(eq("Finagle The Buffalo"))
  end

end
