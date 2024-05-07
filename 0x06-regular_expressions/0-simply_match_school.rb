
#!/usr/bin/env ruby

# Accept the argument
input_string = ARGV[0]

# Define the regular expression
regex = /School/

# Match the regular expression against the input string
match_data = input_string.match(regex)

# Print the matched part of the string
puts match_data[0] if match_data
