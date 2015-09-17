$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

Gem::Specification.new do |gem|
  gem.name = 'acts_as_graph_vertex'
  gem.version = '1.0.0'
  gem.homepage = 'https://github.com/nathankleyn/acts_as_graph_vertex'
  gem.license = 'MIT'

  gem.authors = [
    'Nathan Kleyn'
  ]
  gem.email = [
    'nathan@nathankleyn.com'
  ]
  gem.summary = 'Simple mixin for adding graph like functions (parents, children, traversal, etc) to any class.'
  gem.description = "See #{gem.homepage} for more information!"

  gem.files = Dir['**/*'].select { |d| d =~ %r{^(README.md|lib/)/} }

  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_development_dependency 'filewatcher', '~> 0.3'
  gem.add_development_dependency 'pry-byebug', '~> 2.0'
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'rubocop', '~> 0.28'
  gem.add_development_dependency 'rubocop-rspec', '~> 1.2'
end
