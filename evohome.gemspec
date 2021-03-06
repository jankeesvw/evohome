
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "evohome/version"

Gem::Specification.new do |spec|
  spec.name          = "evohome"
  spec.version       = Evohome::VERSION
  spec.authors       = ["Jankees van Woezik"]
  spec.email         = ["mail@jankeesvw.com"]

  spec.summary       = %q{A gem to read temperature data from Honeywell's Evohome API}
  spec.description   = %q{A gem to read temperature data from Honeywell's Evohome API}
  spec.homepage      = "https://github.com/jankeesvw/evohome"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 4.0"
  spec.add_development_dependency "webmock", "~> 3.1"
  spec.add_development_dependency "rspec-collection_matchers", "~> 1.1"
  spec.add_dependency "httparty", "~> 0.15.6"
end
