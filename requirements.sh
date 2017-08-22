# Report start.
echo 'STARTING requirements.sh'

# Make sure we're in the home directory.
cd /home/repl
echo 'After changing directory, in' $(pwd)

# Get the zip file.
wget https://s3.amazonaws.com/assets.datacamp.com/production/course_5160/datasets/filesys.zip
echo 'after wget doing recursive ls of everything'
ls -R $(pwd)/*

# Make sure we have the unzip command.
apt-get update
apt-get -y install unzip

# Reporting
echo 'About to unzip in' $(pwd)

# Unpack.
unzip ./filesys.zip

# Remove the zip file.
# rm -f ./filesys.zip
echo 'not removing filesys.zip in order to test that its download worked and touching test.txt instead'
touch test.txt
echo 'recursive ls after touching test.txt'
ls -R $(pwd)/*

# Make the `backup` directory (which starts empty).
mkdir ./backup

# Change ownership.
chown -R repl:repl .

# Show what's been installed where.
echo 'About to recursive ls'
ls -R $(pwd)/*

# Report end.
echo 'ENDING requirements.sh'
