require "role_model"
class User < ApplicationRecord
  include CommonModel
  include RoleModel
  attr_normalize_string :username, :email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  roles_attribute :roles_mask
  roles [ :player, :admin ]

  def self.column_names
    [ :username, :email, :roles ]
  end

  def to_s
    username
  end

  def name_with_link
    ApplicationController.helpers.link_to_resource(self, action: :edit)
  end
end
