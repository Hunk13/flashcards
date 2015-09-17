require 'rails_helper'

describe User do
  it "valid user" do
    user = User.new(
      name: "Vasya Pupkin",
      email: "aa@aa.aa",
      password: "password",
      password_confirmation: "password")
    expect(user).to be_valid
  end
end
