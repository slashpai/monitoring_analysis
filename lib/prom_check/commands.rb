# Commands
module PromCheck
  # Contains Possible CLI Options
  class Commands < Thor
    include Helper
    class_option :log_level, type: :string, desc: 'loglevel, default info', aliases: '-l'
    class_option :prom_url, type: :string, desc: 'prometheus_url, default http://localhost:9090', aliases: '-u'

    desc 'labels', 'Get Labels'
    def labels
      validate_options(options)
      PromCheck.logger.info 'Getting labels'
      Labels.get_labels(options)
    end

    desc 'review_labels', 'Review Labels'
    # label value display count
    method_option :lv_display_count, type: :numeric, default: 100000, aliases: '-n'
    def review_labels
      validate_options(options)
      PromCheck.logger.info 'Reviewing labels'
      Labels.review_labels(options)
    end
  end
end
