# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'less/version'

Gem::Specification.new do |s|
  s.name        = 'less-execjs'
  s.version     = Less::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alex MacCaw', 'David Spurr']
  s.license     = 'Apache-2.0'
  s.email       = ['alexmaccaw@twitter.com', 'david.spurr@gmail.com']
  s.homepage    = 'http://lesscss.org'
  s.summary     = 'Leaner CSS, in your browser or Ruby (via less.js)'
  s.description = 'Invoke the Less CSS compiler from Ruby'

  s.files       = `git ls-files`.split("\n")

  module_dirs = `git submodule`.split("\n").map { |e| e.split(' ')[1] }
  module_dirs.each do |dir|
    Dir.chdir(dir) do
      s.files += `git ls-files`.split("\n").map { |f| File.join(dir, f) }
    end
  end

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'execjs', '~> 2.6'

  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'rspec', '~> 2.0'
  s.add_development_dependency 'rubocop', '~> 0.46'
end
