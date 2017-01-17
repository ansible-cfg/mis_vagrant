#/bin/sh
# Run this on a server to perform backups. To run add a cron entry to server:
# 0,4,*,*,* sh /path/to/backup_db.sh
#
# Ensure backup_db.sh has execute permissions added: chmod a+x backup_db.sh.


# Database name to backup. Include the .sql.
DB=db_name.sql

# Storage location for the backed up file.
DOC=/home/srvadmin

# Site docroot to run drush command in. This will pass to drush --root=DOCROOT.
DOCROOT=/var/www/html/docroot/

# URI to pass to drush URI flag.
URI=sitedomain.com

# Remove any previous databases saved.
if [ -f $DOC/$DB.gz ]
then
  rm $DOC/$DB.gz
fi

if [ -f $DOC/$DB ]
then
  rm $DOC/$DB
fi

cd $DOCROOT
/usr/bin/drush --root=$DOCROOT --uri=$URI sql-dump | gzip -c > $DOC/$DB
