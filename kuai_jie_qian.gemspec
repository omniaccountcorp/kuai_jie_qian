# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kuai_jie_qian/version"

Gem::Specification.new do |spec|
  spec.name          = "kuai_jie_qian"
  spec.version       = KuaiJieQian::VERSION
  spec.authors       = ["tony"]
  spec.email         = ["tony@omniaccount.com"]

  spec.summary       = %q{E签宝之快捷签}
  spec.description   = %q{签宝之快捷签接口}
  spec.homepage      = "https://github.com/omniaccountcorp/kuai_jie_qian"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
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
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'byebug', '~> 9.1'
  spec.add_development_dependency 'faker', '~> 1.8', '>= 1.8.4'

  spec.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  spec.add_dependency 'pdfkit', '~> 0.8.2'
  spec.add_dependency 'wkhtmltopdf-binary', '~> 0.12.3.1'
  spec.add_dependency 'grim'
  spec.add_dependency 'rmagick', '~>2.16.0'
end
