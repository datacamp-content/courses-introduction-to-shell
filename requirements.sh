# Definitions.
HOME_DIR=/home/repl
USER_GROUP=repl:repl
COURSE_ID=course_5160
ARCHIVE=filesys.zip

# Report start.
echo ''
echo '----------------------------------------'
echo 'STARTING requirements.sh at ' $(date)
echo 'HOME_DIR: ' ${HOME_DIR}
echo 'USER_GROUP: ' ${USER_GROUP}
echo 'COURSE_ID: ' ${COURSE_ID}
echo 'ARCHIVE: ' ${ARCHIVE}
echo

# Make sure we're in the home directory.
cd ${HOME_DIR}

# Get the zip file.
wget https://s3.amazonaws.com/assets.datacamp.com/production/${COURSE_ID}/datasets/${ARCHIVE}

# Make sure we have unzip.
apt-get update
apt-get -y install unzip

# Unpack to the local directory.
unzip ./${ARCHIVE}

# Remove the zip file.
rm -f ./${ARCHIVE}

# Make the `backup` directory (which starts off empty, so is not in Git).
mkdir ./backup

# Change ownership.
chown -R ${USER_GROUP} .

# Change prompt.
echo "export PS1='\$ '" >> ${HOME_DIR}/.bashrc

# Copy to /.course_home, for resetting exercises
# files there will replace /home/repl each exercise
sudo -u repl rsync -a /home/repl/ /.course_home/

# Show what's been done where.
echo 'Installed in home directory:'
ls -R ${HOME_DIR}/*
echo
echo 'Last 10 lines of .bashrc'
tail -n 10 ${HOME_DIR}/.bashrc

echo '/.course_home dir:'
ls '/.course_home'

# Report end.
echo
echo 'ENDING requirements.sh'
echo '----------------------------------------'
echo ''
