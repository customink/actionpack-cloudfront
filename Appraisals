# We use git repos so we get test directories and their support.

appraise 'rails42' do
  gem 'rails', git: 'git://github.com/rails/rails.git', branch: '4-2-stable'
  gem 'mocha'
end

appraise 'rails50' do
  gem 'rails', git: 'git://github.com/rails/rails.git', branch: '5-0-stable'
end

appraise 'rails51' do
  gem 'capybara'
  gem 'puma'
  gem 'rails', git: 'git://github.com/rails/rails.git', branch: '5-1-stable'
end
