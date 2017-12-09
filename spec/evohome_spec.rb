describe Evohome do
  describe "#connect!" do
    it "connects to the Honeywell api and gets a session id" do
      VCR.use_cassette "connect!" do
        email = "mail@example.com"
        password = "password"
        application_id = "abc-123-456-789-1012345"

        evohome = Evohome.new(username: email, password: password, application_id: application_id)
        evohome.connect!

        expect(evohome.sessionid).to eq "C2736E4E-605A-439D-AFB6-B45C32022D05"
      end
    end
  end

  context "with a valid sessionid and user_id" do
    let(:session_id) { "6CB595A4-0BB5-4F2D-B87F-A901EAC32635" }
    let(:user_id) { "1234" }

    describe "#thermostats" do
      it "gets the thermostats data" do
        VCR.use_cassette "thermostats" do
          evohome = Evohome.new
          evohome.sessionid = session_id
          evohome.user_id = user_id

          expect(evohome).to have(9).thermostats
        end
      end
    end
  end

  describe "Thermostat" do
    it "parses the data" do
      example = {
        "gatewayId" => 1379688,
        "deviceID" => 1679149,
        "thermostatModelType" => "EMEA_ZONE",
        "deviceType" => 128,
        "name" => "Badkamer",
        "scheduleCapable" => false,
        "holdUntilCapable" => false,
        "thermostat" => {
          "units" => "Celsius",
          "indoorTemperature" => 18.12,
          "outdoorTemperature" => 128.0,
          "outdoorTemperatureAvailable" => false,
          "outdoorHumidity" => 128.0,
          "outdootHumidityAvailable" => false,
          "indoorHumidity" => 128.0,
          "indoorTemperatureStatus" => "Measured",
          "indoorHumidityStatus" => "NotAvailable",
          "outdoorTemperatureStatus" => "NotAvailable",
          "outdoorHumidityStatus" => "NotAvailable",
          "isCommercial" => false,
          "allowedModes" => ["Heat", "Off"],
          "deadband" => 0.0,
          "minHeatSetpoint" => 5.0,
          "maxHeatSetpoint" => 35.0,
          "minCoolSetpoint" => 50.0,
          "maxCoolSetpoint" => 90.0,
          "changeableValues" => {
            "mode" => "Off",
            "heatSetpoint" => {
              "value" => 18.0,
              "status" => "Scheduled"
            },
            "vacationHoldDays" => 0
          },
          "scheduleCapable" => false,
          "vacationHoldChangeable" => false,
          "vacationHoldCancelable" => false,
          "scheduleHeatSp" => 0.0,
          "scheduleCoolSp" => 0.0 },
        "alertSettings" => {
          "deviceID" => 1679149,
          "tempHigherThanActive" => true,
          "tempHigherThan" => 30.0,
          "tempHigherThanMinutes" => 0,
          "tempLowerThanActive" => true,
          "tempLowerThan" => 5.0,
          "tempLowerThanMinutes" => 0,
          "faultConditionExistsActive" => false,
          "faultConditionExistsHours" => 0,
          "normalConditionsActive" => true,
          "communicationLostActive" => false,
          "communicationLostHours" => 0,
          "communicationFailureActive" => true,
          "communicationFailureMinutes" => 15,
          "deviceLostActive" => false,
          "deviceLostHours" => 0
        },
        "isUpgrading" => false,
        "isAlive" => true,
        "thermostatVersion" => "01.00.07.01",
        "macID" => "00D02D8D4977",
        "locationID" => 1530109,
        "domainID" => 18807,
        "instance" => 0
      }

      thermostat = Evohome::Thermostat.new(example)
      expect(thermostat.name).to eq "Badkamer"
      expect(thermostat.temperature).to eq 18.12
      expect(thermostat.temperature_setpoint).to eq 18.0
      expect(thermostat.inspect).to eq "<thermostat name='Badkamer' temperature='18.12' temperature_setpoint='18.0'>"
    end
  end
end
