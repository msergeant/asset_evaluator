class AnswerQuestion
  def initialize(asset, question_id, answer, question_list = nil)
    @asset = asset
    @question_id = question_id
    @answer = answer
    @question_list = question_list
  end

  def answer
    @asset.evaluation[@question_id] = @answer
    response = @question_list.dig(@question_id, @answer)
    if response.match(/grade=/)
      @asset.grade = response.split('=')[1]
      {"complete" => true}
    else
      {"complete" => false}
    end
  end
end
