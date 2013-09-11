# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'msgpack_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "msgpack_rails"
  spec.version       = MsgpackRails::VERSION
  spec.authors       = ["Jingwen Owen Ou"]
  spec.email         = ["jingweno@gmail.com"]
  spec.description   = %q{Message Pack for Rails.}
  spec.summary       = %q{The Rails way to serialize/deserialize with Message Pack.}
  spec.homepage      = "https://github.com/jingweno/msgpack_rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 3.0"
  spec.add_runtime_dependency "activemodel", ">= 3.0"
  spec.add_runtime_dependency "msgpack"
end
