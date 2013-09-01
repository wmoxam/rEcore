# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "recore/version"

Gem::Specification.new do |s|
  s.name = "rEcore"
  s.version = REcore::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Wesley Moxam']
  s.email = ['me@wmoxam.com']
  s.homepage = "http://github.com/wmoxam/recore"
  s.summary = %q{High level ruby bindings for Ecore}
  s.description = %q{High level ruby bindings for Ecore}

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

#  s.add_dependency 'ecore-ffi'

  s.add_development_dependency 'gem_box'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end


