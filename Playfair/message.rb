class Message


	attr_accessor :diagraphs
	
	def initialize(messageString)
		@messageString = messageString
		create_diagraphs
	end

	def create_diagraphs

		#letters j & i are interchangable, so replace all instances of I with J
		@messageString.gsub!("I", "J")

		#split the message into two character strings
		@diagraphs = @messageString.scan(/../)
		#check we don't have one left over
		unless @diagraphs.length * 2 == @messageString.length
			#add left over char with letter Z to the array
			@diagraphs[diagraphs.length] = @messageString.scan(/./).last + "Z"
		end

		#if both letters are the same we change the second to an "X" character
		@diagraphs.collect! do |diagraph|
			
			if(diagraph[0, 1] == diagraph[1, 1])
				diagraph[0, 1] + "X"
			else
				diagraph
			end
			
		end

	end

end