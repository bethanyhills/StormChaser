# -*- encoding: utf-8 -*-
# stub: memcachier 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "memcachier"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Amit Levy"]
  s.date = "2011-01-30"
  s.description = "Simple gem that sets the memcached environment variables to the values of corresponding memcachier environment variables.\n                   This makes it seemless to use MemCachier in environments like Heroku using the Dalli or other compatible memcached gem."
  s.email = "support@memcachier.com"
  s.homepage = "http://www.memcachier.com"
  s.rubygems_version = "2.2.0"
  s.summary = "Compatibility gem for using memcached libraries with MemCachier"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version
end
