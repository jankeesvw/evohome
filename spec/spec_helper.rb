require "bundler/setup"
require "vcr"
require "webmock"
require "evohome"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  VCR.configure do |config|
    config.cassette_library_dir = "fixtures/vcr_cassettes"
    config.hook_into :webmock
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
