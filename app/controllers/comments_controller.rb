# frozen_string_literal: true

class CommentsController < ApplicationController
  include CommonController

  def create
    @resource = build_resource(safe_params)
    @resource.related = GlobalID::Locator.locate safe_params[:related_gid]
    @resource.user = current_user
    authorize! :create, @resource

    if @resource.save
      render turbo_stream: turbo_stream.prepend('comments', partial: 'comments/comment', locals: { comment: @resource })
    else
      flash.now[:danger] = "Nie udało się dodać komentarza: #{@resource.errors.full_messages.join(', ')}"
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def destroy
    @resource = Comment.find(params[:id])
    authorize! :destroy, @resource

    if @resource.destroy
      render turbo_stream: turbo_stream.remove("js-comment-#{@resource.id}")
    else
      flash.now[:danger] = "Nie udało się usunąć komentarza."
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:comment).permit(:content, :related_gid)
  end
end
