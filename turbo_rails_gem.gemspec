require_relative "lib/turbo_rails_gem/version"

Gem::Specification.new do |spec|
  spec.name        = "turbo_rails_gem"
  spec.version     = TurboRailsGem::VERSION
  spec.authors     = ["StephanYu"]
  spec.email       = ["stephan.yu@gmail.com"]
  spec.summary     = "A replica of the TurboRailsGem."
  spec.license     = "MIT"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.7.2"
end
