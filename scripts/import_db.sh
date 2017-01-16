#/bin/sh
# The following allows importing a database from an SSH location.
# Future @todo:
#  - Allow to specify database backup URL or filepath (avoid download).
#  - Allow import from S3 or URL to avoid SSH public key requirement.

# SSH connection details to find DB backup.
SSH=username@ssh.host

# Path to the file on server.
SSH_PATH=/home/username/backup.sql.gz

# Stage File Proxy Domain. Include http protocol.
SFP_DOMAIN=http://domain.name.com

# Storage location for downloaded DB. Defaults to /home/vagrant.
DOC=/home/vagrant

# Site root to run drush commands from. Usually a multisite directory.
SITE_ROOT=/home/vagrant/docroot/sites/mis_example.mcdev

# Remove any previous databases saved.
if [ -f $DOC/db.sql.gz ]
then
  rm $DOC/db.sql.gz
fi

if [ -f $DOC/db.sql ]
then
  rm $DOC/db.sql
fi

echo "Import database from " $SSH

time scp $SSH:$SSH_PATH $DOC/db.sql.gz
gunzip $DOC/db.sql.gz

echo "Downloading DB complete. Time to download noted above...Importing DB"

cd $SITE_ROOT

time drush sqlc < $DOC/db.sql

echo "Database imported. Time to import noted above."

drush sql-sanitize -y

drush updb -y
drush en stage_file_proxy -y

drush vset stage_file_proxy_origin $SFP_DOMAIN
drush en devel -y

echo "Cleaning up..."

if [ -f $DOC/db.sql.gz ]
then
  rm $DOC/db.sql.gz
fi

if [ -f $DOC/db.sql ]
then
  rm $DOC/db.sql
fi
