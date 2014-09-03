
class Parser

		def initialize(fileToParse)
			@fileToParse = fileToParse
		end

		def parse

			file = File.new(@fileToParse, "r")
			while (line = file.gets)
				puts line
			end

		end	

end