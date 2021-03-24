lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'action_pack/cloudfront/version'

Gem::Specification.new do |spec|
  spec.name          = 'actionpack-cloudfront'
  spec.version       = ActionPack::Cloudfront::VERSION
  spec.authors       = ['Ken Collins']
  spec.email         = ['kcollins@customink.com']
  spec.summary       = "Configure ActionDispatch::RemoteIp trusted proxies for Amazon CloudFront."
  spec.description   = "Simple gem that adds Amazon CloudFront IP prefixes to the trusted proxies to Rails RemoteIp middleware."
  spec.homepage      = 'https://github.com/customink/actionpack-cloudfront'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency     'actionpack', '>= 4.2'
  spec.add_runtime_dependency     'railties', '>= 4.2'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
end
