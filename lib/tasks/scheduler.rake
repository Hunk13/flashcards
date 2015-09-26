desc "Heroku scheduler tasks"
task notify_card_review: :environment do
  puts "Sending out email reminders for review."
  User.notify_card_review
  puts "Emails sent!"
end