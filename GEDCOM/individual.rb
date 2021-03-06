require './parsedObject'
require 'xml'

class Individual < ParsedObject
	attr_accessor :firstNames, :surname, :sex, :familyId, :dateChanged

	def initialize
		@firstNames = ""
	end

	def process_line(line)
		prefix = line_prefix(line)
		case prefix
			when "SEX"
				 @sex = line_value(line)
			when "NAME"
				 lineCount = get_line_split_count(line)
				 @surname = get_line_split_value(line, lineCount - 1).gsub('/','')
				 firstNameStart = 2
				 firstNameEnd = get_line_split_count(line) - 1
				 while firstNameStart < firstNameEnd
				 	@firstNames = @firstNames + get_line_split_value(line, firstNameStart) + " "
				 	firstNameStart += 1
				 end
				 @firstNames = @firstNames.strip

			when "FAMS"
				 @familyId = line_value(line)
			when "DATE"
				 @dateChanged = get_line_split_value(line, 2) + " " + get_line_split_value(line, 3) + " " + get_line_split_value(line, 4)
		end 
	end

	def set_attributes(element)
		element["id"] = @id
		element["firstNames"] = @firstNames
		element["surname"] = @surname
		element["sex"] = @sex
		element["dateChanged"] = @dateChanged
	end

end
