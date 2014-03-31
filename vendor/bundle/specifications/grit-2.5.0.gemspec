# -*- encoding: utf-8 -*-
# stub: grit 2.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "grit"
  s.version = "2.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tom Preston-Werner", "Scott Chacon"]
  s.date = "2012-04-22"
  s.description = "Grit is a Ruby library for extracting information from a git repository in an object oriented manner."
  s.email = "tom@github.com"
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "http://github.com/mojombo/grit"
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubyforge_project = "grit"
  s.rubygems_version = "2.2.0"
  s.summary = "Ruby Git bindings."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<posix-spawn>, ["~> 0.3.6"])
      s.add_runtime_dependency(%q<mime-types>, ["~> 1.15"])
      s.add_runtime_dependency(%q<diff-lcs>, ["~> 1.1"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<posix-spawn>, ["~> 0.3.6"])
      s.add_dependency(%q<mime-types>, ["~> 1.15"])
      s.add_dependency(%q<diff-lcs>, ["~> 1.1"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<posix-spawn>, ["~> 0.3.6"])
    s.add_dependency(%q<mime-types>, ["~> 1.15"])
    s.add_dependency(%q<diff-lcs>, ["~> 1.1"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
