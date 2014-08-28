require './number'

class Code

	ILL_ERROR_CONST = "ill"
	ERR_ERROR_CONST = "err"
	AMB_ERROR_CONST = "AMB"


	def initialize
		@rawLines = []
		@numbers = []
	end

	def raw_value
		@rawLines.each do |line|
			line
		end
	end

	def add_line(line)
		@rawLines[@rawLines.length] = line
		if @rawLines.length == 4
			set_numbers
		end
	end

	def set_numbers

		numberLength = 3
		counter = 0
		
		@rawLines.each do |line|

			#split string into collection of chars
			charArray = line.scan(/./)
			#each number has three chars
			numberChars = charArray.each_slice(numberLength).to_a
			charCounter = 0
			numberChars.each do |numChar|
				#loop through the split characters
				case counter
				when 0
					#create object and add to array
					currentNumber = Number.new
					@numbers[charCounter] = currentNumber
					#assign array of chars to number
					currentNumber.set_line1(numChar)
				when 1
					currentNumber = @numbers[charCounter]
					#assign array of chars to number
					currentNumber.set_line2(numChar)
				when 2
					currentNumber = @numbers[charCounter]
					#assign array of chars to number
					currentNumber.set_line3(numChar)
				end
				charCounter = charCounter + 1
				end
		    counter = counter + 1
		end

	end

	def to_s
		format_numbers_as_string(@numbers)
	end

	def int_array_to_s(int_array)
		stringVal = ""
		int_array.each do |ia|
			stringVal = stringVal + ia.to_s
		end
		stringVal
	end


	def format_numbers_as_string(numbersToFormat)
		output = ""
		numbersToFormat.each do |numb|
			numInt = numb.integer_value
			calcNumberString = numInt == -1 ? "?" : numInt.to_s
			output = output + calcNumberString
		end

		output
		
	end


	def format_with_error_resolution
		
			if status == ILL_ERROR_CONST || status == ERR_ERROR_CONST
				validAlternatives = get_valid_alternatives
				if validAlternatives.count == 1
					#only one alternative, just display this
					validAlternatives[0]
				elsif validAlternatives.count > 1
					#more than one alternative, we'll display all of them
					retString = ""
					retString = retString + to_s + " " + AMB_ERROR_CONST + " ["
					counter = 1
					validAlternatives.each do |va|
						retString = retString + "'" + va + "'"
						if counter != validAlternatives.length 
							retString = retString + ", "
						else
							retString = retString + "]"
						end
						counter = counter + 1
					end
					retString
				else
					#no alternatives, display original and error
					errFormat = to_s + " "
					if to_s.include?('?')
						 errFormat + ILL_ERROR_CONST
					else
						errFormat + ERR_ERROR_CONST
					end
					
				end
			else
				#no error display original
				to_s
			end



	end

	def get_valid_alternatives

		#loop through the numbers and try alternatives, adding them to
		#an array of they are valid
		validAlternatives = []
		counter = 0
		@numbers.each do |number|
			numberChangedProc = Proc.new{|int|
				tempNumbers = @numbers.dup
				tempNumInts = get_number_ints(tempNumbers)
				tempNumInts[counter] = int
				tempIsValid = check_number_is_valid?(tempNumInts)

				if tempIsValid && !tempNumInts.include?(-1)
				 	validAlternatives[validAlternatives.length] = int_array_to_s(tempNumInts)
				end

			}	
			number.get_alternatives(numberChangedProc)
			counter = counter + 1
		end
		validAlternatives
	end

	def status
		numb = to_s
		statusString = ""
		if numb.include? "?"
			statusString = ILL_ERROR_CONST
		elsif !is_valid?
			statusString =  ERR_ERROR_CONST
		end
		statusString
	end

	def formatted_for_output
		to_s + " " + status
	end

	def is_valid?
		numInts = get_number_ints(@numbers)
		check_number_is_valid?(numInts)
	end

	def get_number_ints(numberObjCollection)
		numerInts = []
		numberObjCollection.each do |num|
			numerInts[numerInts.length] = num.integer_value
		end
		numerInts
	end

	def check_number_is_valid?(number)


			total = (1*number[8]) + (2*number[7]) + (3*number[6]) + (4*number[5]) + 
				(5*number[4]) + (6*number[3]) + (7*number[2]) + (8*number[1]) + 
				(9*number[0])
			total % 11 == 0
		
	end

end
