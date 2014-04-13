require 'digest'
require 'clipboard'
module Hashme
  def salt(file = 'salt.secret')
    salt = ""
    File.open(file, "r") do |f|
      f.each_line { |line| salt << line }
    end
    salt
  end

  def hash2clipboard(text, salt = "")
    salt ||= self.salt
    contents = ""
    contents = Clipboard.paste
    message  = "#{salt}.#{text}"
    hash     = Digest::SHA2.new(256) #basically what you get from sha256
    password = hash <<(message)
    Clipboard.copy(password.to_s)
    password = hash <<('cleanslate')
    password = nil
    sleep self.timeout
    Clipboard.copy(contents)
  end

  def timeout
    5 #in seconds
  end
end
