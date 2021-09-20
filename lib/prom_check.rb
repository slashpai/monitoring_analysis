require 'concurrent-ruby'
require 'json'
require 'logger'
require 'rest-client'
require 'terminal-table'
require 'thor'

require 'prom_check/base'
require 'prom_check/common'
require 'prom_check/http_calls'
require 'prom_check/errors'
require 'prom_check/labels'
require 'prom_check/commands'
require 'prom_check/version'

# prom_check
module PromCheck
  @loggers = {}

  class << self
    # @attribute [rw] prom_url
    # prometheus url
    # @return [String]
    attr_accessor :prom_url
    # @attribute [rw] prom_labels
    # prometheus labels
    # @return [Array]
    attr_accessor :prom_labels
    # @attribute [rw] prom_label_values
    # prometheus label values
    # @return [Hash]
    attr_accessor :prom_label_values
    # @attribute [rw] prom_label_analysis
    # prometheus label analysis
    # @return [Array]
    attr_accessor :prom_label_analysis
    # @attribute [rw] log_level
    # log level for gem
    # @return [String]
    attr_accessor :log_level

    # logger
    def logger
      @log_level ||= 'INFO' unless @log_level
      @logger ||= logger_for(self.class.name)
    end

    def logger_for(classname)
      @loggers[classname] ||= configure_logger_for(classname)
    end

    def configure_logger_for(classname)
      log = Logger.new($stdout)
      log.level = @log_level
      log.progname = classname
      log
    end
  end
end
