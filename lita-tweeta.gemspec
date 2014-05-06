Gem::Specification.new do |spec|
  spec.name          = "lita-tweeta"
  spec.version       = "0.0.1"
  spec.authors       = ["Tristan Chong"]
  spec.email         = ["ong@tristaneuan.ch"]
  spec.description   = %q{A Lita handler that returns the author and text of a linked tweet.}
  spec.summary       = %q{A Lita handler that returns the author and text of a linked tweet.}
  spec.homepage      = "https://github.com/tristaneuan/lita-tweeta"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 3.2"
  spec.add_runtime_dependency "twitter", ">= 5.8.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta2"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
