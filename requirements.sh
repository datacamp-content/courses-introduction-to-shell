# Base name for course.
COURSE=courses-intro-to-unix-shell

# Go into home directory (should be `/home/repl`).
cd

# Clone the GitHub repo for the course.
git clone git@github.com:datacamp/$(COURSE).git

# Make sure it's on the master branch.
git -C $(COURSE) checkout master

# Get everything out of the `filesys` directory here.
mv $(COURSE)/filesys/* .

# Get rid of the cloned repo.
rm -rf $(COURSE)
