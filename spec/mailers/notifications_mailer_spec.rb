require "rails_helper"

describe "Testing Notification Mailer" do
  context "pending card" do
    let!(:user) { create(:user) }
    let!(:mail) { NotificationsMailer.pending_cards(user) }

    it "render subject mail" do
      expect(mail.subject).to eql("Проверь карточки!!!")
    end

    it "send mail to" do
      expect(mail.to).to eql([user.email])
    end

    it "send mail from" do
      expect(mail.from).to eql(["adorarana2584417@mail.ru"])
    end
  end
end
