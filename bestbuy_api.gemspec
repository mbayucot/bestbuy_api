
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bestbuy_api/version"

Gem::Specification.new do |spec|
  spec.name          = "bestbuy_api"
  spec.version       = BestbuyApi::VERSION
  spec.authors       = ['Michael John Bayucot']
  spec.email         = ['mbayucot@gmail.com']

  spec.summary       = 'A Ruby wrapper for the Bestbuy API'
  spec.homepage      = 'https://github.com/mbayucot/bestbuy-api'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'httparty', '~> 0.13'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
  spec.add_development_dependency 'vcr', '~> 4.0', '>= 4.0.0'
  spec.add_development_dependency 'webmock', '~> 3.4', '>= 3.4.2'
end
