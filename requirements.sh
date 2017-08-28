# Definitions.
HOME_DIR=/home/repl
PROFILE=${HOME_DIR}/.profile
USER_GROUP=repl:repl
COURSE_ID=course_5160
ARCHIVE=filesys.zip

# Report start.
echo ''
echo '----------------------------------------'
echo 'STARTING requirements.sh'
echo 'HOME_DIR: ' ${HOME_DIR}
echo 'USER_GROUP: ' ${USER_GROUP}
echo 'COURSE_ID: ' ${COURSE_ID}
echo 'ARCHIVE: ' ${ARCHIVE}

# Make sure we're in the home directory.
cd ${HOME_DIR}

# Get the zip file.
wget https://s3.amazonaws.com/assets.datacamp.com/production/${COURSE_ID}/datasets/${ARCHIVE}

# Make sure we have the following commands:
# - unzip (for installation)
# - tree (for displaying file system)
apt-get update
apt-get -y install unzip
apt-get -y install tree

# Unpack to the local directory.
unzip ./${ARCHIVE}

# Remove the zip file.
rm -f ./${ARCHIVE}

# Make the `backup` and `bin` directories (which start off empty).
mkdir ./backup

# Change ownership.
chown -R ${USER_GROUP} .

# Show what's been installed where.
echo 'Installed in home directory:'
ls -R ${HOME_DIR}/*

# Make sure that HOME points to this directory.
echo "export HOME=${HOME_DIR}" >> ${PROFILE}
echo "Last 10 lines of ${PROFILE}"
tail -n 10 ${PROFILE}

# Report end.
echo 'ENDING requirements.sh'
echo '----------------------------------------'
echo ''
