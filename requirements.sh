# Definitions.
HOME_DIR=/home/repl
HOME_COPY=/.course_home
USER_GROUP=repl:repl
COURSE_ID=course_5065
FILESYS=filesys.zip
SOLUTIONS=solutions.zip

# Report start.
echo ''
echo '----------------------------------------'
echo 'START TIME:' $(date)
echo 'HOME_DIR: ' ${HOME_DIR}
echo 'USER_GROUP: ' ${USER_GROUP}
echo 'COURSE_ID: ' ${COURSE_ID}
echo 'FILESYS: ' ${FILESYS}
echo

# Make sure we're in the home directory.
cd ${HOME_DIR}

# Get the zip files.
wget https://s3.amazonaws.com/assets.datacamp.com/production/${COURSE_ID}/datasets/${FILESYS}
wget https://s3.amazonaws.com/assets.datacamp.com/production/${COURSE_ID}/datasets/${SOLUTIONS}

# Make sure we have nano and unzip.
apt-get update
apt-get -y install nano
apt-get -y install unzip


# Unpack to the local directory.
unzip ./${FILESYS}

# Remove the zip file.
rm -f ./${FILESYS}

# Make the `backup` and `bin` directories (which start off empty, so are not in Git).
mkdir ./backup
mkdir ./bin

# Change ownership.
chown -R ${USER_GROUP} .

# Unpack the solutions (used for file comparison in SCTs).
unzip -d / ./${SOLUTIONS}
rm -f ./${SOLUTIONS}

# Change prompt.
echo "export PS1='\$ '" >> ${HOME_DIR}/.bashrc

# Ensure ~/bin is on the user's path.
echo 'export PATH=$PATH:$HOME/bin' >> ${HOME_DIR}/.bashrc

# Make copy for resetting exercises.
# Files there will replace /home/repl each exercise.
# IMPORTANT: Trailing slashes after directory names force rsync to do the right thing.
rsync -a ${HOME_DIR}/ ${HOME_COPY}/
chown -R ${USER_GROUP} ${HOME_COPY}

# Show what's been done where.
echo 'Installed in home directory:'
ls -R ${HOME_DIR}/*
echo
echo 'Last 10 lines of .bashrc'
tail -n 10 ${HOME_DIR}/.bashrc

echo 'home backup directory:'
ls -R ${HOME_COPY}

echo 'solutions directory'
ls -lR /solutions

# Report end of installation.
echo
echo 'ENDING requirements.sh'
echo '----------------------------------------'
echo ''
