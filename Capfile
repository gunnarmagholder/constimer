load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }