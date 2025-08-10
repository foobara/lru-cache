ENV["FOOBARA_ENV"] ||= "development"

require "bundler/setup"

if ["development", "test"].include?(ENV["FOOBARA_ENV"])
  require "pry"
  require "pry-byebug"
end
