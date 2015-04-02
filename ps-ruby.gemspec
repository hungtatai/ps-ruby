# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ps-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "ps-ruby"
  spec.version       = PS.VERSION
  spec.authors       = ["HondaDai"]
  spec.email         = ["hondadai.tw@gmail.com"]
  spec.summary       = %q{PS-Ruby is a simple ps wrapper with ruby}
  spec.homepage      = "https://github.com/HondaDai/ps-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

end
