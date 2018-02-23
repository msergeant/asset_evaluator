class EvaluateAssetsController < ApplicationController
  before_action :set_asset

  QUESTION_LIST = {
    "housing_cracked" =>{"first" => true, "text" => "Is the housing cracked?", "yes" => "grade=D", "no" => "lcd_scratches"},
    "lcd_scratches" =>{"text" => "Does the LCD have deep scratches?", "yes" => "grade=C", "no" => "dents_in_housing"},
    "dents_in_housing" =>{"text" => "Are there dents in the housing?", "yes" => "grade=C", "no" => "minor_lcd_scratches"},
    "minor_lcd_scratches" =>{"text" => "Are there more than 20 scratches on LCD?", "yes" => "grade=B", "no" => "phone_scratches"},
    "phone_scratches" =>{"text" => "Does the phone have scratches?", "yes" => "grade=A", "no" => "grade=A+"},
  }

  def show
    set_next_question
  end

  def update
    result = AnswerQuestion.new(@asset, params["question_id"], params["response"], QUESTION_LIST).answer
    @asset.save!

    if result["complete"]
      flash[:notice] = "Your grade has been updated!"
      redirect_to asset_url(@asset)
    else
      set_next_question(params["question_id"])
      render "show.html"
    end
  end

private
  def set_asset
    @asset = Asset.find(params[:id])
  end

  def set_next_question(question_id=nil)
    next_question = NextQuestion.new(@asset, question_id, QUESTION_LIST).next
    @question_id = next_question["next_question_id"]
    @question_text = QUESTION_LIST.dig(@question_id, "text")
  end
end
