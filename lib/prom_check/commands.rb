# Commands
module PromCheck
  # Contains Possible CLI Options
  class Commands < Thor
    include Helper
    class_option :log_level, type: :string, default: 'info', aliases: '-l'
    class_option :prom_url, type: :string, default: 'http://localhost:9090', required: true, aliases: '-u'

    desc 'labels', 'Get Labels'
    def labels
      validate_options(options)
      PromCheck.logger.info 'Getting labels'
      Labels.get_labels(options)
    end

    desc 'review_labels', 'Review Labels'
    def review_labels
      validate_options(options)
      PromCheck.logger.info 'Reviewing labels'
      Labels.review_labels(options)
    end
  end
end
