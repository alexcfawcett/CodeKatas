#http://en.wikipedia.org/wiki/Playfair_cipher
require './cipher'
require './message'

message = Message.new('SETUPOLD')
cipher = Cipher.new('JOSEPHFAWCETT')
puts cipher.encrypt_message(message.diagraphs)