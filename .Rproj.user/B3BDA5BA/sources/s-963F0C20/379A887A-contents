# Week 1
# Configuring git

git --version
git help
git config user.name
git config user.email

# Create a local repository
pwd
mkdir repos
cd repos mkdir projecta
cd projecta
git init 

# Verify that your project directory contains a .git directory
ls -a

# Make a file and add to the staging area
touch fileA.txt
git status 
git add fileA.txt
# add . adds all new files; add -u adds any updated/changed files
git status

# Ignore files by adding them to gitignore
cat .gitignore
echo "*.pdf" >> .gitignore
echo "*.csv" >> .gitignore
echo "*.dta" >> .gitignore
echo "*.svg" >> .gitignore
echo "*.rds" >> .gitignore

#Commit to a local repository
git commit -m "add fileA.txt"
git status

# See commit details
git log
git log --oneline

# Clone a remote repository
git clone https://bitbucket.org/atlassian_tutorial/helloworld.git
cd helloworld
ls
# 
git remote -v
# url used to clone the repository is shown. Can use "origin" instead.

# Push to a remote repository. First clone a Bitbucket repository
git clone https://joerothwell@bitbucket.org/joerothwell/projectb.git
cd projectb
la -a
git remote -v
echo "# projectb's README" > README.md
# add file to staging area and commit
git add README.md
git commit -m "add README.md"
git status

# Push the commit to the remote repository. Origin is a shortcut for the URL
# and master is the branch to push. Local and remote repos are now sync'd.
git push -u origin master

# (Not in MOOC)
# To sync an existing R studio project with a github repo, they must first have the same name.
# Then get the project URL and do git remote
git remote add origin https://github.com/USERNAME/PROJECT.git

# If there are different files in the github repository, they must first be pulled
# Otherwise an error message will appear
git pull origin master --allow-unrelated-histories
git push -u origin master

# Rename a file (then stage and commit as usual)
git mv file.txt file_rename.txt



