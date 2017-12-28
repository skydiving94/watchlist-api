require 'rails_helper'

RSpec.describe Administrator, type: :model do
  it {should have_many(:stocks)}

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
end
