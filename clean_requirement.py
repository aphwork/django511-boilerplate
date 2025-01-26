with open('requirements.txt', 'r') as infile, open('v1.requirements.txt', 'w') as outfile:
    for line in infile:
        if '@ file:///' not in line:
            outfile.write(line)
