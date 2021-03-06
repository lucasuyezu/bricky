module Bricky
  class Requirements
    def check_and_execute
      if pending_requirements
        print "Make sure you have the following requirements: " 
        puts requirements.join(',').colorize(:red)
      else
        yield          
      end
    end

    private
      def requirements
        ["docker"]
      end
  
      def pending_requirements
        requirements.detect do |command|
          not system("which #{command} > /dev/null 2>&1")
        end
      end
  end
end
