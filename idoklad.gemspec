Gem::Specification.new do |s|
  s.name        = 'idoklad'
  s.version     = '1.0.0'
  s.date        = '2017-08-07'
  s.summary     = "iDoklad"
  s.description = "A ruby gem for iDoklad.cz api."
  s.authors     = ["Jiri Prochazka"]
  s.email       = 'prochazka@coderocket.co'
  s.homepage    = 'https://github.com/CodeRocketCo/iDoklad'
  s.license     = 'MIT'

  s.add_runtime_dependency "oauth2"
  s.add_runtime_dependency "json"
  s.files       = %w[LICENSE.md README.md idoklad.gemspec] + Dir['lib/**/*.rb']
end
