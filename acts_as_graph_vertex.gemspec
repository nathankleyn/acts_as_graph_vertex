# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

Gem::Specification.new do |gem|
  gem.name = 'acts_as_graph_vertex'
  gem.version = '1.1.0'
  gem.homepage = 'https://github.com/nathankleyn/acts_as_graph_vertex'
  gem.license = 'MIT'

  gem.authors = ['Nathan Kleyn']
  gem.email = ['nathan@nathankleyn.com']
  gem.summary = 'Simple mixin for adding graph like functions (parents, children, traversal, etc) to any class.'
  gem.description = <<~DESC
    Simple mixin for adding graph like functions (parents, children, traversal,
    etc) to any class. Effectively, you'll get DAG (directed acyclic graph)
    behaviour between your classes and therefore the ability to model parent,
    child and sibling behaviours with ease!
  DESC

  gem.files = Dir['**/*'].select { |d| d =~ %r{^(README.md|lib/)/} }

  gem.add_development_dependency 'coveralls', '~> 0.8.22'
  gem.add_development_dependency 'filewatcher', '~> 1.1', '>= 1.1.1'
  gem.add_development_dependency 'pry-byebug', '~> 3.6', '>= 3.6.0'
  gem.add_development_dependency 'rspec', '~> 3.8', '>= 3.8.0'
  gem.add_development_dependency 'rubocop', '~> 0.59.2'
  gem.add_development_dependency 'rubocop-rspec', '~> 1.29', '>= 1.29.1'
end
