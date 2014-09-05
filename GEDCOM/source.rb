require './parsedObject'

class Source < ParsedObject

	attr_accessor :name, :version, :company 

	def process_line(line)
		super(line)
		prefix = line_prefix(line)
		case prefix
			when "VERS"
				@version = line_value(line)
			when "CORP"
				@company = line_value(line)	
		end
	end

end