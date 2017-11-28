source "https://rubygems.org"

gemspec

group :development do
  if RUBY_VERSION >= "2.0.0"
    gem "pry-byebug"
  else
    gem "pry-debugger"
  end
end

group :test do
  gem "rake",   "~> 12.3"
  gem "rspec",  "~> 3.7.0"
end
