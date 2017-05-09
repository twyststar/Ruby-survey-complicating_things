require('spec_helper')

describe(Question) do
  describe("#survey") do
    it("tells which survey it belongs to") do
      test_survey = Survey.create({:name => "Kitten preference"})
      test_question1 = Question.create({:q_text => "Do you prefer a black or white kitten?", :survey_id => test_survey.id()})
      expect(test_question1.survey()).to(eq(test_survey))
    end
  end

  it("validates presence of description") do
    @question = Question.new({:q_text => ""})
    expect(@question.save()).to(eq(false))
  end

  describe('#opt_1') do
    it('has opt_1')do
      @question = Question.new({:q_text => "", :opt_1 => "opt_1"})
      expect(@question.opt_1()).to(eq("opt_1"))
    end
  end
  describe('#opt_1') do
    it('has opt_1')do
      @question = Question.new({:q_text => "", :opt_1 => "opt_1"})
      expect(@question.opt_1?()).to(eq(true))
    end
  end
  describe('#opt_1') do
    it('has no opt_1')do
      @question = Question.new({:q_text => ""})
      expect(@question.opt_1?()).to(eq(false))
    end
  end
end
