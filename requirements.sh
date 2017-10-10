# Definitions.
HOME_DIR=/home/repl
USER_GROUP=repl:repl
COURSE_ID=course_5160
FILESYS=filesys.zip
SOLUTIONS=solutions.zip

# Report start.
echo ''
echo '----------------------------------------'
echo 'STARTING requirements.sh at ' $(date)
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

# Make sure we have unzip.
apt-get update
apt-get -y install unzip

# Make sure we have the shellwhat_ext extensions.
pip3 install git+https://github.com/gvwilson/shellwhat_ext.git
python3 -c "import sys; print('sys.version:', sys.version); import shellwhat_ext; print('shellwhat_ext version:', shellwhat_ext.__version__)"

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
unzip -d /tmp ./${SOLUTIONS}
rm -f ./${SOLUTIONS}

# Change prompt.
echo "export PS1='\$ '" >> ${HOME_DIR}/.bashrc
echo 'export PATH=$PATH:$HOME/bin' >> ${HOME_DIR}/.bashrc

# Copy to /.course_home, for resetting exercises
# files there will replace /home/repl each exercise
rsync -a /home/repl/ /.course_home/
chown -R ${USER_GROUP} /.course_home/

# Show what's been done where.
echo 'Installed in home directory:'
ls -R ${HOME_DIR}/*
echo
echo 'Last 10 lines of .bashrc'
tail -n 10 ${HOME_DIR}/.bashrc

echo '/.course_home directory:'
ls -R /.course_home

# Report end.
echo
echo 'ENDING requirements.sh'
echo '----------------------------------------'
echo ''
