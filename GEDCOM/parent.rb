require './header'
require './parsedObject'
require './individual'
require './family'
require 'xml'

class Parent < ParsedObject

		def initialize(fileToParse)
			@fileToParse = fileToParse
			@individuals = []
			@families = []
		end

		def parse

			file = File.new(@fileToParse, "r")

			currentObj = nil;
			while (line = file.gets)
				
				if line[0] == '0'
					#new object
					if(currentObj != nil)
						
					end
					currentObj = object_for_line(line)
				else
					currentObj.process_line(line)
				end
			end


=begin


			@individuals.each do |indiv|
				puts "id=" + indiv.id
				puts "surname= " + indiv.surname
				puts "sex= " + indiv.sex
				puts "date= " + indiv.dateChanged
				puts "firstNames= " + indiv.firstNames
				if indiv.familyId != nil 
					puts "famid= " + indiv.familyId
				end

			end


			@families.each do |fam|
				puts fam.id
				puts fam.husbandId
				puts fam.wifeId
				puts fam.childIds
			end
=end
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
				indiv.id = line_prefix(line)
				@individuals[@individuals.length] = indiv
				indiv
			when "FAM"
				family = Family.new
				family.id = line_prefix(line)
				@families[@families.length] = family
				family
			else
				Individual.new
			end

		end

		def print_xml

			printFams = @families.dup

			xml = XML::Document.new
			xml.root = XML::Node.new("data")

			header = XML::Node.new("header")
			header["name"] = @header.source.name
			header["version"] = @header.source.version
			header["company"] = @header.source.company
			xml.root << header
	
			famlilies = XML::Node.new("families")

			printFams.each do |fam|
				famElement = XML::Node.new("family")
				if(fam.husbandId != nil)
					husElement = XML::Node.new("husband")
					get_individual(fam.husbandId).set_attributes(husElement)
					famElement << husElement
				end

				if(fam.wifeId != nil)
					wifeElement = XML::Node.new("wife")
					get_individual(fam.wifeId).set_attributes(wifeElement)
					famElement << wifeElement
				end

				if fam.childIds.count > 0
					children = XML::Node.new("children")
				end

				fam.childIds.each do |chId|
					child = XML::Node.new("child") 
					get_individual(chId).set_attributes(child)
					children << child
				end

				if fam.childIds.count > 0
					famElement << children
				end

				famlilies << famElement
			end
			xml.root << famlilies

			puts xml.to_s

		end

		def get_individual(id)
			retval = nil
			@individuals.each do |indiv| 
				if indiv.id == id 
					retval = indiv
				end
			end
			retval
		end

end