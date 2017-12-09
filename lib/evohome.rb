require "evohome/version"
require "httparty"

class Evohome
  attr_accessor :sessionid
  attr_accessor :user_id

  def initialize(username: nil, password: nil, application_id: nil)
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
    @user_id = response["userInfo"]["userID"]

    self
  end

  def thermostats
    url = "https://tccna.honeywell.com/WebAPI/api/locations?userId=#{@user_id}&allData=True"

    response = HTTParty.get(url,
                            headers: {
                              "Content-Type" => "application/json",
                              "sessionID" => @sessionid,
                            })

    response.first["devices"].map { |d| Thermostat.new(d) }
  end

  class Thermostat
    attr_accessor :name, :temperature, :temperature_setpoint, :mode

    def initialize(data)
      @name = data["name"]
      @temperature = data["thermostat"]["indoorTemperature"]
      @temperature_setpoint = data["thermostat"]["changeableValues"]["heatSetpoint"]["value"]
      @mode = data["thermostat"]["changeableValues"]["mode"]
    end

    def inspect
      "<thermostat name='#{name}' temperature='#{temperature}' temperature_setpoint='#{temperature_setpoint}' mode='#{mode}'>"
    end
  end
end
