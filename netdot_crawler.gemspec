# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'netdot_crawler/version'

Gem::Specification.new do |spec|
  spec.name          = "netdot_crawler"
  spec.version       = "0.0.1"
  spec.authors       = ["Raissa Ferreira"]
  spec.email         = ["rai200890@gmail.com"]
  spec.summary       = "Netdot Crawler"
  spec.description   = "Netdot Crawler"
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.files =  ["lib/client.rb","lib/crawler.rb","lib/netdot_crawler.rb","lib/xml_parser.rb","lib/version.rb"]
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "nokogiri"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
