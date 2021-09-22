# prom_check

prom_check is used to do prometheus analysis by querying prometheus api.

## Installation

Build and install it yourself as:

```ruby
gem build
gem install prom_check-<VERSION>.gem
```

## Features

- [x] Get Labels
- [x] Review Labels

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

### Get Labels

```ruby
Usage:
  prom_check labels

Options:
  -l, [--log-level=LOG_LEVEL]  # loglevel, default info
  -u, [--prom-url=PROM_URL]    # prometheus_url, default http://localhost:9090

Get Labels
```

### Review Labels

```ruby
Usage:
  prom_check review_labels

Options:
  -n, [--lv-display-count=N]
                               # Default: 100000
  -l, [--log-level=LOG_LEVEL]  # loglevel, default info
  -u, [--prom-url=PROM_URL]    # prometheus_url, default http://localhost:9090

Review Labels
```

### Examples

#### Get Labels

- Without debug mode

    ```ruby
    prom_check labels -u http://demo.robustperception.io:9090
    ```

- With debug mode
    **Note:** Nothing specific in debug mode for this command

    ```ruby
    prom_check labels -u http://demo.robustperception.io:9090 -l debug
    ```

#### Review Labels

- Without debug mode

  ```ruby
  prom_check review_labels -u http://demo.robustperception.io:9090
  ```

- With debug mode

  ```ruby
  prom_check labels -u http://demo.robustperception.io:9090 -l debug
  ```

- Display only top 20 label values by label value length (default if not passed the `-n` flag it will display all (max 100000))

  ```ruby
  prom_check review_labels -n 20 -u http://demo.robustperception.io:9090
  ```

## Development

After checking out the repo, run `bundle install` to install dependencies.  You can also run `bundle exec bin/prom_check` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome
