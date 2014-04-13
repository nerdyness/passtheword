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
    password = (hash <<(message)).to_s
    # add some "randomness"
    password.sub!('a', '@') # replace first occurence of a with @
    password.sub!('3', '.') # replace first occurence of 3 with .
    all_digits     = password[/\d+/]
    # slice the string in 3 parts and upcase the middle
    first_number   = all_digits[0].to_i #0-9
    second_number  = all_digits[1].to_i
    first_number  += 10
    second_number += 15
    part1 = password.slice!(0..first_number)
    part2 = password.slice!(0..second_number).upcase
    password = part1 + part2 + password
    Clipboard.copy(password)
    password = hash <<('cleanslate')
    password = nil
    sleep(self.timeout)
    Clipboard.copy(contents)
  end

  def timeout
    5 #in seconds
  end
end
