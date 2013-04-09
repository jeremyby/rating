# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "omniauth-google-oauth2"
  s.version = "0.1.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Ellithorpe", "Yury Korolev"]
  s.date = "2013-04-09"
  s.description = "A Google oauth2 strategy for OmniAuth 1.0"
  s.email = ["quest@mac.com"]
  s.files = [".gitignore", ".rvmrc", "Gemfile", "README.md", "Rakefile", "examples/config.ru", "examples/omni_auth.rb", "lib/omniauth-google-oauth2.rb", "lib/omniauth/google_oauth2.rb", "lib/omniauth/google_oauth2/version.rb", "lib/omniauth/strategies/google_oauth2.rb", "omniauth-contrib.gemspec", "spec/omniauth/strategies/google_oauth2_spec.rb", "spec/spec_helper.rb", "spec/support/shared_examples.rb"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "A Google oauth2 strategy for OmniAuth 1.0"
  s.test_files = ["spec/omniauth/strategies/google_oauth2_spec.rb", "spec/spec_helper.rb", "spec/support/shared_examples.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>, ["~> 1.0"])
      s.add_runtime_dependency(%q<omniauth-oauth2>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<omniauth>, ["~> 1.0"])
      s.add_dependency(%q<omniauth-oauth2>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<omniauth>, ["~> 1.0"])
    s.add_dependency(%q<omniauth-oauth2>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
