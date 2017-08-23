# Report start.
echo '----------------------------------------'
echo 'STARTING requirements.sh'

# Make sure we're in the home directory.
cd /home/repl

# Get the zip file.
wget https://s3.amazonaws.com/assets.datacamp.com/production/course_5160/datasets/filesys.zip

# Make sure we have the unzip command.
apt-get update
apt-get -y install unzip

# Unpack.
unzip ./filesys.zip

# Remove the zip file.
rm -f ./filesys.zip

# Make the `backup` and `bin` directories (which start off empty).
mkdir ./backup

# Change ownership.
chown -R repl:repl .

# Show what's been installed where.
echo 'Installed files'
ls -R $(pwd)/*

# Report end.
echo 'ENDING requirements.sh'
echo '----------------------------------------'
