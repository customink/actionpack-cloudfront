# Actionpack::Cloudfront

Configure Rails' [ActionDispatch::RemoteIp](http://api.rubyonrails.org/classes/ActionDispatch/RemoteIp.html) to use Amazon CloudFront's IP ranges as trusted proxies.

## Installation & Usage

Add this line to your Rails application's Gemfile. No other configuration is needed.

```ruby
gem 'actionpack-cloudfront'
```

## How It Works

The gem works by making an API call to [https://ip-ranges.amazonaws.com/ip-ranges.json](https://ip-ranges.amazonaws.com/ip-ranges.json), selecting all `CLOUDFRONT` services and pushing each IP prefix to the following config:

```ruby
ActionDispatch::Railtie.config.action_dispatch.trusted_proxies
```

The API request has a timeout of 5 seconds and will only be made when the `Rails.env` is not test or development. If the timeout is reached, a local backup JSON file is used.


## Updating Backup JSON

This uses the [jq](https://stedolan.github.io/jq/) binary to parse/clean the output.

```shell
curl -s "https://ip-ranges.amazonaws.com/ip-ranges.json" | jq . > lib/action_pack/cloudfront/ip-ranges.json
```

## Contributing

We use the [Appraisal](https://github.com/thoughtbot/appraisal) gem from Thoughtbot to help us test different versions of Rails. The `appraisal rake test` subcommand runs our test suite against all Rails versions in the `Appraisal` file. So after cloning the repo, running the following commands.

```shell
$ bundle install
$ bundle exec appraisal update
$ bundle exec appraisal rake test
```

If you want to run the tests for a specific appraisal, use one of the names found in our `Appraisal` file. For example, the following will run our tests suite for Rails 4.2 only.

```shell
$ bundle exec appraisal rails72 rake test
```

## Alternatives

* [cloudfront-rails](https://github.com/dinks/cloudfront-rails) - Leverages cached HTTP requests to Cloudfront to extend Rails' trusted proxies list thru method patching vs assigning to ActionDispatch's trusted proxies config.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
