require './CipherCharacter'

class Cipher

	POSSIBLE_KEY_CHARS_CONST = "ABCDEFGHJKLMNOPQRSTUVWXYZ"

	def initialize(key)
		@key = key
		create_cipher
	end


	def create_cipher
		#create the cipher we will use for encyryption
		
		#letters j & i are interchangable, so replace all instances of I with J
		@key.gsub!("I", "J")

		#remove any duplicate characters
		keyChars = @key.scan(/./)
		addedChars = []
		dedupedString = ""
		keyChars.each do |char|
			#loop through characters adding each to an new array of added chars
			unless addedChars.include?(char)
				addedChars[addedChars.length] = char
				dedupedString << char
			end
		end

		@rowCount = 1
		@colcount = 1

		#we have the keystring, now create a hash assigning each char in the string to a number
		@cipherHash = Hash.new(25)
		@counter = 1
		finalKeyChars = dedupedString.scan(/./)
		finalKeyChars.each do |fChar|
			create_cipher_character(fChar)
			break if @counter == 26
		end
		
		#we now need to add the rest of the characters to make up 25
		possibleChars = POSSIBLE_KEY_CHARS_CONST.scan(/./)	
		possibleChars.each do |pChar|
			unless finalKeyChars.include?(pChar)
				create_cipher_character(pChar)
				
				break if @counter == 26
			end
		end
	end


	def create_cipher_character(char)
		@cipherHash[char] = CipherCharacter.new(@counter, @colcount, @rowCount)
		@counter = @counter + 1
		@colcount = @colcount + 1
		
		if @colcount == 6
			@colcount = 1
			@rowCount = @rowCount + 1
		end	
	end

	def encrypt_message(diagraphs)

		encryptedMessage = ""
		diagraphs.each do |diagraph|
			encryptedMessage = encryptedMessage + encrypt_diagraph(diagraph)
		end
		encryptedMessage
	end


	def decrypt_message(message)
		clearText = ""
		decryptDiagraphs = message.scan(/../)
		decryptDiagraphs.each do |ecdgph|
			chars = ecdgph.scan(/./)
			firstChar =  @cipherHash[chars[0]]
			secondChar = @cipherHash[chars[1]]
			if is_in_same_column?(firstChar, secondChar)
				 clearText << get_decrypted_column_letter(firstChar.intValue) + get_decrypted_column_letter(secondChar.intValue)
			elsif is_in_same_row?(firstChar, secondChar)
				#letters are in same row
				 clearText << get_decrypted_row_letter(firstChar.intValue) + get_decrypted_row_letter(secondChar.intValue)
			else
				#letters are in rectange
				clearText << get_encrypted_rect_letter(firstChar, secondChar) + get_encrypted_rect_letter(secondChar, firstChar)
			end
		end
		clearText

	end

	def is_in_same_column?(firstInt, secondInt)
		firstInt.x == secondInt.x
	end

	def get_encrypted_column_letter(initiailPosition)
		newPosition = initiailPosition + 5
		if newPosition < 26
			#no need to wrap round, just add five
			get_letter_for_position(newPosition)
		else
			#wrap round the column, take 20
			get_letter_for_position(initiailPosition - 20)
		end
	end

	def get_decrypted_column_letter(initialPosition)
		newPosition = initialPosition - 5
		if newPosition > 1
			get_letter_for_position(newPosition)
		else
			get_letter_for_position(initialPosition + 20)
		end
	end


	def is_in_same_row?(firstInt, secondInt)
		firstInt.y == secondInt.y
	end

	def get_decrypted_row_letter(initialPosition)
		
		if (initialPosition - 1) % 5 == 0
			get_letter_for_position(initialPosition + 4)
		else	
			get_letter_for_position(initialPosition - 1)
		end

	end

	def get_encrypted_row_letter(initialPosition)
		
		if initialPosition % 5 == 0

			#if divisible by 5 then its last in row, wrap round by taking four
			get_letter_for_position(initialPosition - 4)
		else	
			get_letter_for_position(initialPosition + 1)
		end

	end

	def get_encrypted_rect_letter(letter_to_encrypt, second_letter)
		get_letter_for_coordinate(second_letter.x, letter_to_encrypt.y)
	end

	def get_decrypted_rect_letter(letter_to_encrypt, second_letter)
		get_letter_for_coordinate(second_letter.x, letter_to_encrypt.y)
	end


	def encrypt_diagraph(diagraph)
		#we need the position of each character of the diagraph
		chars = diagraph.scan(/./)
		firstChar = @cipherHash[chars[0]]
		secondChar = @cipherHash[chars[1]]
		if is_in_same_column?(firstChar, secondChar)
			 #letters are in same column, encrypt both and return
			 get_encrypted_column_letter(firstChar.intValue) + get_encrypted_column_letter(secondChar.intValue)
		elsif is_in_same_row?(firstChar, secondChar)
			#letters are in same row
			 get_encrypted_row_letter(firstChar.intValue) + get_encrypted_row_letter(secondChar.intValue)
		else
			#letters are in rectange
			get_encrypted_rect_letter(firstChar, secondChar) + get_encrypted_rect_letter(secondChar, firstChar)
		end
				

	end

	def get_letter_for_position(position)
		retval = ""
		@cipherHash.each do |key, value|
			if value.intValue == position
				retval = key
			end
		end
		retval
	end 

	def get_letter_for_coordinate(x, y)
		retval = "?"
		@cipherHash.each do |key, value|
			if value.x == x && value.y == y
				retval = key
			end
		end
		retval
	end
	

end