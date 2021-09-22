module PromCheck
  # Helper module which contains common methods
  module Helper
    def validate_options(options)
      PromCheck.log_level = options[:log_level] ? options[:log_level].upcase : 'INFO'
      PromCheck.prom_url = options[:prom_url] ? options[:prom_url] : 'http://localhost:9090'
    end

    # print table
    def print_table(headings, rows)
      table = Terminal::Table.new headings: headings, rows: rows
      puts table
    end

    # print data
    # input only array
    def print_data(header, data)
      puts header
      counter = 0
      data.each do |row|
        counter += 1
        puts "#{counter}\t #{row}"
      end
    end

    # draw line
    def draw_line(newline = false)
      puts "\n----------------------------------------------------------" if newline
      puts "----------------------------------------------------------" unless newline
    end
  end
end
