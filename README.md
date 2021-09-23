# prom_check

prom_check is created to do prometheus analysis by querying prometheus api

## Installation

### Installing in a ruby environment

Build and install it yourself as:

```ruby
gem build
gem install prom_check-<VERSION>.gem
```

### Using Docker

**Build Image**

```go
docker build . -t prom_check:0.1.0
```

- Using externally accessible url

  **Example:**

  ```go
  docker run prom_check:0.1.0 prom_check labels -u http://demo.robustperception.io:9090
  ```

- If need to pass localhost link of prometheus running on hostmachine

  **Example:**

  ```go
  docker run --network=host prom_check:0.1.0 prom_check labels
  ```

  or
  
  ```go
  docker run --network=host prom_check:0.1.0 prom_check labels -u http://localhost:9090
  ```

Other [examples](#examples) is applicable for docker as well or use `help` flag to get options available

## Features

- [x] Get Labels
- [x] Review Labels (Labels, Label Name Lengths and Label Values)

## Usage

```ruby
Commands:
  prom_check help [COMMAND]  # Describe available commands or one specific command
  prom_check labels          # Get Labels
  prom_check review_labels   # Review Labels

Options:
  -l, [--log-level=LOG_LEVEL]  # loglevel, default info
  -u, [--prom-url=PROM_URL]    # prometheus_url, default http://localhost:9090
```

### Get Labels

Get all labels from prometheus

```ruby
Usage:
  prom_check labels

Options:
  -l, [--log-level=LOG_LEVEL]  # loglevel, default info
  -u, [--prom-url=PROM_URL]    # prometheus_url, default http://localhost:9090

Get Labels
```

### Review Labels

Get all labels, analyze label name lengths, label value lengths and print analysis

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

## TODO

- [ ] Print metric corresponding to large label values
- [ ] Add more features
- [ ] Add Tests

## Contributing

- Bug reports and pull requests are welcome

  - Fork the project on GitHub
  - Clone the project
  - Add changes (and tests if applicable)
  - Commit and push
  - Create a pull request
