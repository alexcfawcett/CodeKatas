#http://en.wikipedia.org/wiki/Playfair_cipher
require './cipher'
require './message'

clearText = "ALEXANDERCHRISTOPHERFAWCETT"
message = Message.new(clearText)
cipher = Cipher.new('THISISTHECIPHER')
puts "Cleartext = " + clearText
encrypted = cipher.encrypt_message(message.diagraphs)
puts "Encrypted Text = " + encrypted
puts "Decrypted Text = " + cipher.decrypt_message(encrypted)