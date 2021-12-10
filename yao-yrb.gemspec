lib = File.expand_path('./lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yao/yrb/version'

Gem::Specification.new do |spec|
  spec.name          = 'yao-yrb'
  spec.version       = Yao::Yrb::VERSION
  spec.authors       = ['Yuki Koya']
  spec.email         = ['buty4649@gmail.com']

  spec.summary       = 'irb with yao'
  spec.description   = 'irb with yao (https://github.com/yaocloud/yao)'
  spec.homepage      = 'https://github.com/buty4649/yao-yrb'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)

    spec.metadata['rubygems_mfa_required'] = 'true'
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/buty4649/yao-yrb'
    spec.metadata['changelog_uri'] = 'https://github.com/buty4649/yao-yrb'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'yao'

  spec.add_dependency 'clamp', '~> 1.3.1'
  spec.add_dependency 'pry', '~> 0.13.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rubocop'
end
