#!/bin/bash
usage()
{
cat << EOF
Usage: ./security-review.sh uri.dev /path/to/docroot

ARGUMENTS:
   $URI: URI of site to run code review against.
   $SITE_PATH: Absolute path to Drupal docroot.
EOF
}

URI=$1
SITE_PATH=$2

# Exit if options aren't set.
if [[ -z $SITE_PATH || -z $URI ]]; then
  usage
  exit 1;
fi

# Get security_review module in case it doesn't exist.
if [ ! -f ~/.drush/security_review/security_review.drush.inc ]; then
  mkdir ~/.drush/security_review
  curl http://cgit.drupalcode.org/security_review/plain/security_review.drush.inc?h=7.x-1.2  --output ~/.drush/security_review/security_review.drush.inc
  curl http://cgit.drupalcode.org/security_review/plain/security_review.inc?h=7.x-1.2 --output ~/.drush/security_review/security_review.inc
fi

cd $SITE_PATH

# Run security_reviewq module.
drush security-review --uri=$URI
