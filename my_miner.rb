require 'digest/sha1'

tree = ARGV[0]
parent = ARGV[1]
timestamp = ARGV[2]
difficulty = ARGV[3]

i=0

begin
  i = i + 1
  
  body = "tree #{tree}\nparent #{parent}\nauthor CTF user <me@example.com> #{timestamp} +0000\ncommitter CTF user <me@example.com> #{timestamp} +0000\n\nGive me a Gitcoin\n\n#{i}"
  
  sha1 = Digest::SHA1.hexdigest "commit #{body.length}\0 #{body}"

end while sha1 > difficulty
puts sha1
cmd="git hash-object -t commit --stdin -w <<< '#{body}'"

puts cmd
puts `#{cmd}`
puts `echo '#{body}'`
cmd="git reset --hard #{sha1} > /dev/null"
`#{cmd}`