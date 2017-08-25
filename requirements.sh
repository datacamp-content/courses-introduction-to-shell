# Definitions.
HOME_DIR=/home/repl
SOLUTIONS_DIR=/usr/local/share/solutions
USER_GROUP=repl:repl
COURSE_ID=course_5160
ARCHIVE=filesys.zip

# Report start.
echo ''
echo '----------------------------------------'
echo 'STARTING requirements.sh'
echo 'HOME_DIR: ' $(HOME_DIR)
echo 'SOLUTIONS_DIR: ' $(SOLUTIONS_DIR)
echo 'USER_GROUP: ' $(USER_GROUP)
echo 'COURSE_ID: ' $(COURSE_ID)
echo 'ARCHIVE: ' $(ARCHIVE)

# Make sure we're in the home directory.
cd $(HOME_DIR)

# Get the zip file.
wget https://s3.amazonaws.com/assets.datacamp.com/production/$(COURSE_ID)/datasets/$(ARCHIVE)

# Make sure we have the unzip command.
apt-get update
apt-get -y install unzip

# Unpack to the local directory.
unzip ./$(ARCHIVE)

# Remove the zip file.
rm -f ./$(ARCHIVE)

# Make the `backup` and `bin` directories (which start off empty).
mkdir ./backup

# Move the solutions files to $(SOLUTIONS_DIR).
rm -rf $(SOLUTIONS_DIR)
mv ./solutions $(SOLUTIONS_DIR)

# Change ownership.
chown -R $(USER_GROUP) . $(SOLUTIONS_DIR)

# Show what's been installed where.
echo 'Installed in home directory:'
ls -R $(HOME_DIR)/*
echo 'Installed in $(SOLUTIONS_DIR):'
ls -R $(SOLUTIONS_DIR)/*

# Report end.
echo 'ENDING requirements.sh'
echo '----------------------------------------'
echo ''
