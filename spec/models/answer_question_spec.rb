require 'rails_helper'

RSpec.describe AnswerQuestion do

  let(:question_list) {
    {
      "question1" => {"text" => "Does it meet the first condition?", "yes" => "question2", "no" => "grade=C"},
      "question2" => {"text" => "Does it meet the second condition?", "yes" => "question3", "no" => "grade=B"},
      "question3" => {"text" => "Does it meet the third condition?", "yes" => "grade=Z", "no" => "grade=A"}
    }
  }

  describe "#answer" do
    it "goes to the second question when the answer is yes" do
      asset = Asset.new

      result = AnswerQuestion.new(asset, "question1", "yes", question_list).answer
      expect(result).to eq({"complete" => false})
      expect(asset.evaluation).to eq({"question1" => "yes"})
      expect(asset.grade).to eq(nil)
    end

    it "changes the grade when the answer is no" do
      asset = Asset.new

      result = AnswerQuestion.new(asset, "question1", "no", question_list).answer
      expect(result).to eq({"complete" => true,})
      expect(asset.evaluation).to eq({"question1" => "no"})
      expect(asset.grade).to eq("C")
    end
  end
end

