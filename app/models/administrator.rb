class Administrator < ApplicationRecord
  has_secure_password

  has_many :stocks, foreign_key: :added_by
  validates_presence_of :name, :email, :password_digest
end
