#This will enable us to clean up our syntax by using 
#Factory Girl methods.

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end