require 'rails_helper'

RSpec.describe Stock, type: :model do
  it {should validate_presence_of(:code)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:highest)}
  it {should validate_presence_of(:lowest)}
  it {should validate_presence_of(:current)}
  it {should validate_presence_of(:difference)}
end
