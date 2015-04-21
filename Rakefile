require "bundler/gem_tasks"
require 'lib/crawler'
desc "Retorna do Netdot todos os aps com seus pais, dadas as credenciais"
task :aps_with_parent, [:username, :password] do |t, args|
  NetdotCrawler::Crawler.new(args.username, args.password).aps_with_parent
end