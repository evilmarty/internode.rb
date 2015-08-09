# Internode Ruby Client

This is an unofficial ruby client for Internode's usage and account API. A CLI is also included as a convenient way to retrieve information via the command line.

**Note** At time of writing Internode's API is unstable, 500ing quote often. This is not an issue with the client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'internode'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install internode

## Usage

```ruby
require "internode"

account = Internode::Account.new(
  username: "<account username>", # or leave blank to use ENV["INTERNODE_USERNAME"]
  password: "<account password>"  # or leave blank to use ENV["INTERNODE_PASSWORD"]
)

# Get all the services for the account
account.services

service = account.services.first

# Get service plan
service.details.plan

# Get service speed (as string)
service.details.speed

# Get rollover date (as string)
service.details.rollover

# Get plan interval (usually monthly)
service.details.plan_interval

# Get plan cost (as string)
service.details.plan_cost

# Get service quota
service.usage.quota    # in bytes
service.usage.quota_mb # in megabytes, not mebibytes
service.usage.quota_gb # in gigabytes, not gibibytes

# Get service total usage
service.usage.total    # in bytes
service.usage.total_mb # in megabytes, not mebibytes
service.usage.total_gb # in gigabytes, not gibibytes

# Get percentage used
service.usage.percentage

# Get all details for the services
account.details # Same as account.services.map(&:details)

# Get all usage information for the services
account.usage # Same as account.services.map(&:usage)
```

## TODO

* Add support for service history

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/evilmarty/internode.rb

