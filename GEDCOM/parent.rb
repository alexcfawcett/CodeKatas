require './header'
require './parsedObject'
require './individual'

class Parent < ParsedObject

		def initialize(fileToParse)
			@fileToParse = fileToParse
			@individuals = []
		end

		def parse

			file = File.new(@fileToParse, "r")

			currentObj = nil;
			while (line = file.gets)
				
				if line[0] == '0'
					#new object
					if(currentObj != nil)
						#sputs currentObj.lines.length
					end
					currentObj = object_for_line(line)
				else
					currentObj.process_line(line)
				end

			end


			@individuals.each do |indiv|
				puts "surname= " + indiv.surname
				puts "sex= " + indiv.sex
				puts "date= " + indiv.dateChanged
				puts "firstNames= " + indiv.firstNames
				if indiv.familyId != nil 
					puts "famid= " + indiv.familyId
				end

			end

		end

		def object_for_line(line)
			prefix = line_prefix(line)
			case prefix
			when "HEAD"
				@header = Header.new
			else
				if prefix[0,1] == "@"
					object_for_value(line)
				else
					super(line)
				end

			end
		end

		def object_for_value(line)
			prefix = line_value(line)
			case prefix
			when "INDI"
				indiv = Individual.new
				@individuals[@individuals.length] = indiv
				indiv
			else
				Individual.new
			end

		end
end