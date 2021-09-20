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
      value_lengths = {}
      label_values.each do |lv|
        value_lengths[lv] = lv.size
      end
      value_lengths
    end

    # analyze label values
    def analyze_label_values
      label_value_hash = {}
      largest_in_each_label = []
      rows = []
      puts "\n----------------------------------------------------------"
      PromCheck.logger.debug "\nLabel and corresponding values"
      puts '----------------------------------------------------------'
      PromCheck.prom_label_values.each do |label, values|
        PromCheck.logger.debug "| #{label} \t|  #{values} |"
        value_lengths = get_label_value_length(values)
        rows << [label, value_lengths]
        label_value_hash.merge!(value_lengths)
      end

      puts "\n----------------------------------------------------------"
      PromCheck.logger.debug 'Labels and corresponding value along its length'
      puts '----------------------------------------------------------'
      rows.each do |row|
        PromCheck.logger.debug "| #{row[0]} |\t#{row[1].values} |"
        largest_in_each_label << row[1].values.sort.reverse[0]
      end
      puts "\n----------------------------------------------------------"
      PromCheck.logger.info 'Labels values along with its length in descending order'
      puts '----------------------------------------------------------'
      label_value_hash = label_value_hash.sort_by { |_k, v| v }.reverse
      label_value_hash.each do |value, length|
        # checking metric this way wouldn't be 100% accurate if we don't check every label so search_value_label() checks all labels
        PromCheck.logger.info "labels #{search_value_label(value)} #{value}\t#{length}"
      end

      PromCheck.prom_label_analysis << "Largest value length from label values: #{largest_in_each_label.sort.reverse[0]}"
    end

    # search labels with given label value
    def search_value_label(label_value)
      labels = []
      PromCheck.prom_label_values.each do |key, values|
        labels << key if values.include?(label_value)
      end
      return labels
    end
  end
end
