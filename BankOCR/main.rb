#http://code.joejag.com/coding-dojo-bank-ocr/
require './code'

#open and read file
file = File.new("format.txt", "r")

#set height of each row
numberRowHeight = 4
heightCounter = 0

#parse the file into an array of codes
codes = Array.new

while (line = file.gets)
	if heightCounter == 0
		#first line of code create new code object
		codeObj = Code.new
	end

	#set line
	codeObj.add_line line
	heightCounter = heightCounter + 1
	
	if heightCounter == (numberRowHeight)
		#reached max height for a code, add to array and reset counter
		codes[codes.length] = codeObj
		heightCounter = 0		
	end
end


#User Story 1

codes.each do |code|
	
	puts code.raw_value
	puts code.to_s

end



#User Story 2
=begin
codes.each do |code|
	
	puts code.to_s + " valid = " + code.is_valid?.to_s

end
=end

#User Story 3
=begin
codes.each do |code|
	
	puts code.formatted_for_output

end
=end


#User Story 4
=begin
codes.each do |code|
	puts code.format_with_error_resolution
end
=end





