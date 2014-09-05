require './parsedObject'
require './source'

class Header < ParsedObject

	attr_accessor :source

	def initialize
		@currentObject = nil
	end

	def process_line(line)
		super(line)
		if(line[0,1] == "1")
			@currentObject = object_for_line(line)
		else
			@currentObject.process_line(line)
		end
	end

		def object_for_line(line)
			prefix = line_prefix(line)
			case prefix
			when "SOUR"
				@source = Source.new
				@source.name = line_value(@line)
				@source
			else
				super(prefix)
			end
		end

end