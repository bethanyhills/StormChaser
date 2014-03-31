# -*- encoding: utf-8 -*-
# stub: jazz_hands 0.5.2 ruby lib

Gem::Specification.new do |s|
  s.name = "jazz_hands"
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Gopal Patel"]
  s.date = "2013-10-24"
  s.description = "Spending hours in the rails console? Spruce it up and show off those hard-working hands! jazz_hands replaces IRB with Pry, improves output through awesome_print, and has some other goodies up its sleeves."
  s.email = "nixme@stillhope.com"
  s.homepage = "https://github.com/nixme/jazz_hands"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.2.0"
  s.summary = "Exercise those fingers. Pry-based enhancements for the default Rails console."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pry>, ["~> 0.9.12"])
      s.add_runtime_dependency(%q<pry-rails>, ["~> 0.3.2"])
      s.add_runtime_dependency(%q<pry-doc>, ["~> 0.4.6"])
      s.add_runtime_dependency(%q<pry-git>, ["~> 0.2.3"])
      s.add_runtime_dependency(%q<pry-stack_explorer>, ["~> 0.4.9"])
      s.add_runtime_dependency(%q<pry-remote>, [">= 0.1.7"])
      s.add_runtime_dependency(%q<pry-debugger>, ["~> 0.2.2"])
      s.add_runtime_dependency(%q<hirb>, ["~> 0.7.1"])
      s.add_runtime_dependency(%q<coolline>, [">= 0.4.2"])
      s.add_runtime_dependency(%q<awesome_print>, ["~> 1.2"])
      s.add_runtime_dependency(%q<railties>, ["< 5.0", ">= 3.0"])
    else
      s.add_dependency(%q<pry>, ["~> 0.9.12"])
      s.add_dependency(%q<pry-rails>, ["~> 0.3.2"])
      s.add_dependency(%q<pry-doc>, ["~> 0.4.6"])
      s.add_dependency(%q<pry-git>, ["~> 0.2.3"])
      s.add_dependency(%q<pry-stack_explorer>, ["~> 0.4.9"])
      s.add_dependency(%q<pry-remote>, [">= 0.1.7"])
      s.add_dependency(%q<pry-debugger>, ["~> 0.2.2"])
      s.add_dependency(%q<hirb>, ["~> 0.7.1"])
      s.add_dependency(%q<coolline>, [">= 0.4.2"])
      s.add_dependency(%q<awesome_print>, ["~> 1.2"])
      s.add_dependency(%q<railties>, ["< 5.0", ">= 3.0"])
    end
  else
    s.add_dependency(%q<pry>, ["~> 0.9.12"])
    s.add_dependency(%q<pry-rails>, ["~> 0.3.2"])
    s.add_dependency(%q<pry-doc>, ["~> 0.4.6"])
    s.add_dependency(%q<pry-git>, ["~> 0.2.3"])
    s.add_dependency(%q<pry-stack_explorer>, ["~> 0.4.9"])
    s.add_dependency(%q<pry-remote>, [">= 0.1.7"])
    s.add_dependency(%q<pry-debugger>, ["~> 0.2.2"])
    s.add_dependency(%q<hirb>, ["~> 0.7.1"])
    s.add_dependency(%q<coolline>, [">= 0.4.2"])
    s.add_dependency(%q<awesome_print>, ["~> 1.2"])
    s.add_dependency(%q<railties>, ["< 5.0", ">= 3.0"])
  end
end
