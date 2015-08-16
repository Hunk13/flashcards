require 'rails_helper'

describe User do
  it "valid user" do
    user = User.new(
      email: "aa@aa.aa",
      password: "password")
    expect(user).to be_valid
  end
end
