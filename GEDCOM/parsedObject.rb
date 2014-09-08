class ParsedObject

	attr_accessor :lines, :id

	def initialize
		@lines = []
	end

	def process_line(line)
		@line = line
	end


	def line_prefix(line)
		get_line_split_value(line, 1)
	end

	def line_value(line)
		 value = ""
		 valueStart = 2
		 valueEnd = get_line_split_count(line) 
		 while valueStart < valueEnd
		 	value = value + get_line_split_value(line, valueStart) + " "
		 	valueStart += 1
		 end
		value.strip
	end 


	def object_for_line(line)
		return ParsedObject.new
	end

	def get_line_split_value(line, index)
		line.split[index]
	end
	
	def get_line_split_count(line)
		line.split.count
	end

end