require './parsedObject'

class Family < ParsedObject
	attr_accessor :husbandId, :wifeId, :childIds

	def initialize
		@childIds = []
	end

	def process_line(line)
		prefix = line_prefix(line)
		case prefix
			when "HUSB"
				 @husbandId = line_value(line)
			when "WIFE"
				 @wifeId = line_value(line)	
			when "CHIL"
				 @childIds[@childIds.length] = line_value(line)
		end 
	end


end
