require 'rails_helper'

RSpec.describe AnswerQuestion do

  let(:question_list) {
    {
      "first_question" => {"text" => "Does it meet the first condition?", "yes" => "second_question", "no" => "grade=C"},
      "second_question" => {"text" => "Does it meet the second condition?", "yes" => "second_question", "no" => "grade=B"},
      "third_question" => {"text" => "Does it meet the third condition?", "yes" => "third_question", "no" => "grade=A"}
    }
  }

  describe "#answer" do
    it "goes to the second question when the answer is yes" do
      asset = Asset.new

      result = AnswerQuestion.new(asset, "first_question", "yes", question_list).answer
      expect(result).to eq({"complete" => false, "next_question" => "second_question"})
      expect(asset.evaluation).to eq({"first_question" => "yes"})
      expect(asset.grade).to eq(nil)
    end

    it "changes the grade when the answer is no" do
      asset = Asset.new

      result = AnswerQuestion.new(asset, "first_question", "no", question_list).answer
      expect(result).to eq({"complete" => true,})
      expect(asset.evaluation).to eq({"first_question" => "no"})
      expect(asset.grade).to eq("C")
    end
  end
end

