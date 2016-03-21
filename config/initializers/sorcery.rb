Rails.application.config.sorcery.submodules = [:remember_me, :external]

Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:github, :twitter, :facebook]

  config.github.key = ENV["OUATH_GITHUB_KEY"]
  config.github.secret = ENV["OUATH_GITHUB_SECRET"]
  config.github.callback_url = ENV["OAUTH_GITHUB_CALLBACK_URL"]
  config.github.scope = "user:email"
  config.github.user_info_mapping = { name: "name", email: "email" }

  config.twitter.key = ENV["OUATH_TWITTER_KEY"]
  config.twitter.secret = ENV["OUATH_TWITTER_SECRET"]
  config.twitter.callback_url = ENV["OAUTH_TWITTER_CALLBACK_URL"]
  config.twitter.user_info_mapping = { name: "screen_name", email: "screen_name" }

  config.user_config do |user|
    user.authentications_class = Authentication
    user.username_attribute_names = [:email]
    user.remember_me_for = 1209600 # Two weeks in seconds
  end

  config.user_class = "User"
end
