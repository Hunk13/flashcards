class NotificationsMailer < ApplicationMailer
  default from: ENV["MAIL_USER"]

  def pending_cards(user)
    @user = user
    @cards = user.cards_for_review
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"]
    message_params = { from: ENV["GMAIL_USERNAME"],
                       to: @user.email,
                       subject: t("mailer.subject"),
                       text: "This mail is sent using Mailgun API via mailgun-ruby" }
    mg_client.send_message ENV["MAILGUN_DOMAIN"], message_params
  end
end
