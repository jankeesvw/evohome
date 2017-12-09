# Evohome

This gets all temperatures from you Evohome, it only reads the temperature and setpoint for now.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'evohome'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install evohome

## Usage

```ruby
require "evohome"

email = "email@example.com"
password = "secret"
application_id = "application_id"

evohome = Evohome.new(username: email, password: password, application_id: application_id)
evohome.connect!

loop do 
  values = evohome.thermostats.map { |t| t.inspect }
  system 'clear'
  puts values
  sleep 10
end

# <thermostat name='Badkamer' temperature='19.16' temperature_setpoint='18.0' mode='Off'>
# <thermostat name='Fien' temperature='17.0' temperature_setpoint='16.0' mode='Off'>
# <thermostat name='Hal' temperature='20.96' temperature_setpoint='21.0' mode='Off'>
# <thermostat name='Kantoor' temperature='10.14' temperature_setpoint='20.5' mode='Off'>
# <thermostat name='Keuken' temperature='18.51' temperature_setpoint='22.0' mode='Off'>
# <thermostat name='Slaapkamer' temperature='11.17' temperature_setpoint='7.5' mode='Off'>
# <thermostat name='Soof' temperature='12.97' temperature_setpoint='10.0' mode='Off'>
# <thermostat name='Washok' temperature='12.09' temperature_setpoint='10.0' mode='Off'>
# <thermostat name='Woonkamer' temperature='21.06' temperature_setpoint='22.5' mode='Off'>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/evohome.
