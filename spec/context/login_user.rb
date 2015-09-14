shared_context "logged user" do
  before :each do
    user = create(:user, email: "aa@aa.aa", password: "12345")
    default_login
    deck = create(:deck, user_id: user.id)
  end
end
