Gem::Specification.new do |s|
  s.name        = 'rss-to-cms'
  s.version     = "0.0.1"
  s.version     = "#{s.version}.#{ENV['SNAP_PIPELINE_COUNTER']}" if ENV['SNAP_CI'] == "true"
  s.date        = Date.today.to_s
  s.summary     = "RSS RDF to CMS converter."
  s.description = s.summary
  s.authors     = [ "W3CBrasil" ]
  s.files       = Dir["lib/*"] + Dir["bin/*"] + Dir["assets/**/*"]
  s.executables << 'fetch-and-load-rss-into-cms'
  s.homepage    = 'https://github.com/W3CBrasil/od4d-rss-to-cms'
  s.license     = 'MIT'

  s.add_dependency 'htmlentities', '~> 4.3.2'
  s.add_dependency 'pg', '~> 0.17.1'

end
