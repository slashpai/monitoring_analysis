# labels review
module PromCheck
  # Label related methods
  class Labels < Base
    include Helper
    @access_methods = %i[get_labels review_labels]
    # https://prometheus.io/docs/prometheus/latest/querying/api/#getting-label-names
    # GET /api/v1/labels
    def prometheus_label_api(url)
      prom_url = url.strip if url
      prom_url = 'http://localhost:9090' unless url
      prom_url.concat('/api/v1/labels')
    end

    # https://prometheus.io/docs/prometheus/latest/querying/api/#querying-label-values
    # GET /api/v1/label/<label_name>/values
    def prometheus_query_label_value_api(url, label)
      prom_url = url.strip if url
      prom_url = 'http://localhost:9090' unless url
      prom_url.concat("/api/v1/label/#{label}/values")
    end

    def get_labels(options)
      # set labels_api
      labels_api = prometheus_label_api(options[:prom_url])
      # get labels
      PromCheck.prom_labels = Request.new.async.get(labels_api).value['data']
      print_data(['Labels'], PromCheck.prom_labels)
    end

    def review_labels(options)
      get_labels(options)
      analyze_labels
      print_data(['Analysis'], PromCheck.prom_label_analysis)
    end

    # analyze labels
    def analyze_labels
      PromCheck.prom_label_analysis = []
      headings = ['Label', 'Name Length', 'Value API']
      rows = []
      name_lengths = []
      PromCheck.prom_labels.each do |label|
        rows << [label, label.size, prometheus_query_label_value_api(PromCheck.prom_url, label)]
      end
      rows.select { |row| name_lengths << row[1] }

      PromCheck.prom_label_analysis << "Total Labels: #{rows.size}"
      PromCheck.prom_label_analysis << "Largest Label Name Length: #{name_lengths.sort.reverse[0]}"

      print_table(headings, rows)
      get_label_values(rows)
    end

    # get each label values
    def get_label_values(label_rows)
      PromCheck.prom_label_values = {}
      PromCheck.logger.info 'Getting Label Values, it will take sometime depending on number of labels'
      label_rows.each do |row|
        # The data section of the JSON response is a list of string label values.
        PromCheck.prom_label_values[row[0]] = Request.new.async.get(row[2]).value['data']
      end
      analyze_label_values
    end

    # get length of each label value
    def get_label_value_length(label_values)
      lengths = []
      label_values.each do |lv|
        lengths << lv.size
      end
      lengths
    end

    # analyze label values
    def analyze_label_values
      largest_in_each_label = []
      rows = []
      puts '----------------------------------------------------------'
      PromCheck.logger.debug "\nLabel and corresponding values"
      puts '----------------------------------------------------------'
      PromCheck.prom_label_values.each do |label, values|
        PromCheck.logger.debug "| #{label} \t|  #{values} |"
        rows << [label, get_label_value_length(values)]
      end

      puts '----------------------------------------------------------'
      PromCheck.logger.debug 'Labels and corresponding value lengths'
      puts '----------------------------------------------------------'
      rows.each do |row|
        PromCheck.logger.debug "| #{row[0]} |\t#{row[1]} |"
        largest_in_each_label << row[1].sort.reverse[0]
      end
      PromCheck.prom_label_analysis << "Largest value length from label values: #{largest_in_each_label.sort.reverse[0]}"
    end
  end
end
