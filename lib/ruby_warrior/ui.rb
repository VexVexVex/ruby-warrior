module RubyWarrior
  class UI
    class << self
      def puts(msg)
        Config.out_stream.puts(msg) if Config.out_stream
      end
      
      def puts_with_delay(msg)
        result = puts(msg)
        sleep(Config.delay) if Config.delay
        result
      end
      
      def print(msg)
        Config.out_stream.print(msg) if Config.out_stream
      end
      
      def gets
        Config.in_stream ? Config.in_stream.gets : ''
      end
      
      def request(msg)
        print(msg)
        request = gets
        request ||= ''
        request.chomp
      end
      
      def ask(msg)
        request("#{msg} [yn] ") == 'y'
      end
      
      # REFACTORME
      def choose(item, options)
        if options.length == 1
          response = options.first
        else
          options.each_with_index do |option, i|
            if option.kind_of? Array
              puts "[#{i+1}] #{option.last}"
            else
              puts "[#{i+1}] #{option}"
            end
          end
          choice = request("Choose #{item} by typing the number: ")
          response = options[choice.to_i-1]
        end
        if response.kind_of? Array
          response.first
        else
          response
        end
      end
    end
  end
end
