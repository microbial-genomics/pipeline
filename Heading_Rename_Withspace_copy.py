import sys
# Read input file

file_name = sys.argv[1] # Name of input file specified with path from terminal

input_file = open(file_name, 'r') # Open input file for reading 

content = input_file.readlines() # Read input file one line at a time

new_file = open(file_name[:-6] + '_Modified' + file_name[-6:], 'w') # Create a new file for writing

content2 = file_name[57:-6]

i = 0

for line in content:

        content[i] = line.strip('\n') # Remove any white space or newlines

        if i % 2 == 0:
                content[i] = '>' + content2 # Replace headers (always even-numbered index)
        else:
                content[i] = content[i] + '\n'

        new_file.write(content[i] + '\n') # Write line to modified file and add a newline

        i = i + 1
	
print ''
print 'Original file: ' + input_file.name
print ''
print 'New file: ' + new_file.name

input_file.close()
new_file.close()
