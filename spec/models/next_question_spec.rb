require 'rails_helper'

RSpec.describe NextQuestion do

  let(:question_list) {
    {
      "first_question" => {"first" => true, "text" => "Does it meet the first condition?", "yes" => "second_question", "no" => "grade=C"},
      "second_question" => {"text" => "Does it meet the second condition?", "yes" => "second_question", "no" => "grade=B"},
      "third_question" => {"text" => "Does it meet the third condition?", "yes" => "third_question", "no" => "grade=A"}
    }
  }

  describe "#next" do
    it "returns the first question_id when nothing has been answered yet" do
      result = NextQuestion.new(Asset.new, question_list).next

      expect(result).to eq({"next_question_id" => "first_question"})
    end

    it "returns the second question_id when first question has been answered" do
      asset = Asset.new(evaluation: {"first_question" => "yes"})
      result = NextQuestion.new(asset, question_list).next

      expect(result).to eq({"next_question_id" => "second_question"})
    end

    it "returns nil if the first question does not lead to more questions" do
      asset = Asset.new(evaluation: {"first_question" => "no"})
      result = NextQuestion.new(asset, question_list).next

      expect(result).to eq({"next_question_id" => nil})
    end
  end
end


