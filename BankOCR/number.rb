class Number

 	attr_accessor :pattern


 	def integer_value
 		@intValue == nil ? -1 : @intValue	
 	end

 	def set_line1 (line1)
 		@line1 = line1
 		try_set_integer
 	end

 	def set_line2 (line2)
 		@line2 = line2
 		try_set_integer
 	end

 	def set_line3 (line3)
 		@line3 = line3
 		try_set_integer
 	end

 	def try_set_integer
 		
 		if @line1 != nil && @line2 != nil && @line3 != nil
 			line1String = get_string_from_array(@line1)
			line2String = get_string_from_array(@line2)	
			line3String = get_string_from_array(@line3)
			@pattern = line1String + line2String + line3String
			@intValue = integer_for_pattern(@pattern)
 		end
 	end

 	def get_string_from_array(arrayForString)
 		retval = ""
 		arrayForString.each do |arString|
 			retval = retval + arString
 		end
 		retval
 	end

 	def get_alternatives(newNumberProc)
 		#split pattern into array
 		charArray = @pattern.scan(/./)
 		originalInt = integer_for_pattern(@pattern)
 		
 		counter = 0
 		charArray.each do |char|
 			tempPatternPipe = @pattern.dup
 			find_matches("|", tempPatternPipe, originalInt, counter, newNumberProc)
 			tempPatternUnderscore = @pattern.dup
			find_matches("_", tempPatternUnderscore, originalInt, counter, newNumberProc)
			tempPatternUnderblank = @pattern.dup
			find_matches(" ", tempPatternUnderblank, originalInt, counter, newNumberProc)
			counter = counter + 1
 		end
 	end

 	def find_matches(charToReplace, pattern, originalInt, index, newNumberProc)
 		pattern[index, 1] = charToReplace
 		tempInt = integer_for_pattern(pattern)
 		if tempInt != -1 && tempInt != originalInt
 			newNumberProc.call(tempInt)
 		end
 	end



 	def integer_for_pattern(patternToMatch) 		
 		retval = -1
 		case patternToMatch
 		when " _ | ||_|"
 			retval = 0
 		when "     |  |"
 			retval = 1
 		when " _  _||_ "
 			retval = 2
 		when " _  _| _|"
 			retval = 3
 		when "   |_|  |"
 			retval = 4
 		when " _ |_  _|"
 			retval = 5
 		when " _ |_ |_|"
 			retval = 6
 		when " _   |  |"
 			retval = 7
 		when " _ |_||_|"
 			retval = 8
 		when " _ |_| _|"
 			retval = 9
 		end
 		retval
 	end

end