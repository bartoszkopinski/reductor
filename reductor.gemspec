Gem::Specification.new do |s|
  s.name        = 'reductor'
  s.version     = '0.0.2'
  s.date        = '2013-07-12'
  s.summary     = "Map-reduce with ease."
  s.description = "Collection of common map_reduce operations, implemented with mongoid."
  s.authors     = ["Marcin Stecki"]
  s.email       = 'marcin@netguru.co'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.homepage    =
    'http://rubygems.org/gems/hola'
end
