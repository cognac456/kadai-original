class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
#  config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')] #180616 https://qiita.com/Inp/items/cc447237e23bf10d159e
end
