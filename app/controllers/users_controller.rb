# frozen_string_literal: true

class UsersController < ApplicationController
  include CommonController
  responders :collection
  
  def render_datatable
    render json: UserDatatable.new(params)
  end

  private

  def safe_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :roles_mask, roles: [])
  end
end
