FILESYS=$(wildcard filesys/*.txt) $(wildcard filesys/*/*.txt) $(wildcard filesys/*/*.csv)
SOLUTIONS=$(wildcard solutions/*.sh) $(wildcard solutions/*.out)

all : datasets/filesys.zip datasets/solutions.zip

datasets/filesys.zip : ${FILESYS}
	cd filesys && zip -r ../$@ .

datasets/solutions.zip : ${SOLUTIONS}
	zip -r $@ solutions
