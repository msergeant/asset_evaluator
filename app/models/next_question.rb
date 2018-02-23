class NextQuestion
  def initialize(asset, question_id, question_list = nil)
    @asset = asset
    @question_id = question_id
    @question_list = question_list
  end

  def next
    if @question_id.nil? || @asset.evaluation.empty?
      first_question_id = @question_list.find{|k,v| v["first"]}&.[](0)
      {"next_question_id" => first_question_id}
    else
      answer = @asset.evaluation.fetch(@question_id)
      response = @question_list.dig(@question_id, answer)

      if response.match(/grade=/)
        {"next_question_id" => nil}
      else
        {"next_question_id" => response}
      end
    end
  end
end
