class Stock < ApplicationRecord
  # validations
  validates_presence_of :code, :name, :highest, :lowest,
  :current, :difference
end
