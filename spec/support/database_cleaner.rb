#This is a variation of the example given in 
#Database Cleaner's readme. Basically, this gem ensures 
#that our test database is wiped clean before each test.
RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end