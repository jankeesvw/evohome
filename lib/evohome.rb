require "evohome/version"
require "httparty"

class Evohome
  attr_reader :sessionid

  def initialize(username:, password:, application_id:)
    @username = username
    @password = password
    @application_id = application_id
  end

  def connect!
    response = HTTParty.post("https://tccna.honeywell.com/WebAPI/api/Session",
                             body: { "username" => @username,
                                     "password" => @password,
                                     "ApplicationId" => @application_id }.to_json,
                             headers: { "Content-Type" => "application/json" })

    @sessionid = response["sessionId"]
    self
  end
end
