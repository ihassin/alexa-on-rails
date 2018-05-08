require 'trello'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
  config.member_token = ENV['TRELLO_MEMBER_TOKEN']
end

class DashboardQueryIntent < AlexaIntent
  def prepare_request(intent_request, session)
    log_session session

    handle_request
  end

  def handle_request
    list = Trello::List.find(ENV['TRELLO_BOARD']).cards.sample(5).map(&:name).join(',')
    "Here's a sample of what we're working on. #{list}"
  end
end
