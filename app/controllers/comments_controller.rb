# frozen_string_literal: true

class CommentsController < ApplicationController
  include CommonController

  def callback_before_create
    @resource.related = GlobalID::Locator.locate safe_params[:related_gid]
    @resource.user = current_user
  end

  private

  def safe_params
    params.require(:comment).permit(:user_id, :content, :related_gid)
  end
end
