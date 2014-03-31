# -*- encoding: utf-8 -*-
# stub: coolline 0.4.3 ruby lib

Gem::Specification.new do |s|
  s.name = "coolline"
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mon ouie"]
  s.date = "2014-01-21"
  s.description = "A readline-like library that allows to change how the input\nis displayed.\n"
  s.email = "mon.ouie@gmail.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "http://github.com/Mon-Ouie/coolline"
  s.rubygems_version = "2.2.0"
  s.summary = "Sounds like readline, smells like readline, but isn't readline"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<riot>, [">= 0"])
    else
      s.add_dependency(%q<riot>, [">= 0"])
    end
  else
    s.add_dependency(%q<riot>, [">= 0"])
  end
end
