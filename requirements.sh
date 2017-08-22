# Report start.
echo 'STARTING requirements.sh'

# Make sure we're in the home directory.
cd /home/repl

# Get the zip file.
wget https://s3.amazonaws.com/assets.datacamp.com/production/course_5160/datasets/filesys.zip

# Make sure we have the unzip command.
apt-get update
apt-get -y install unzip

# Reporting
echo 'About to unzip in' $(pwd)

# Unpack.
unzip ./filesys.zip

# Remove the zip file.
rm -f ./filesys.zip

# Make the `backup` directory (which starts empty).
mkdir ./backup

# Change ownership.
chown -R repl:repl .

# Show what's been installed where.
ls -R $(pwd)/*

# Report end.
echo 'ENDING requirements.sh'
