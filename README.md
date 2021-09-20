# prom_check

prom_check is used to do prometheus analysis by querying prometheus api.

## Installation

Build and install it yourself as:

```ruby
gem build
gem install prom_check-<VERSION>.gem
```

## Features

[x] Get Labels

[x] Review Labels

## Usage

```ruby
prom_check
Commands:
  prom_check help [COMMAND]  # Describe available commands or one specific command
  prom_check labels          # Get Labels
  prom_check review_labels   # Review Labels

Options:
  -l, [--log-level=LOG_LEVEL]  
                               # Default: info
  -u, --prom-url=PROM_URL      
                               # Default: http://localhost:9090
```

## Development

After checking out the repo, run `bundle install` to install dependencies.  You can also run `bundle exec bin/prom_check` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome
