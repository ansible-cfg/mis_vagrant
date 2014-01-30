# Utils

## ApacheSolr

1. Uncomment ```utils::solr``` recipe from the run list.
2. Be sure that the apachesolr module is part of your project.

### Defaults

* Version: 3.6.2

  **Note**
  If you are using version ApacheSolr 4.6.x and apachesolr <= version 7.x-1.6,
  you'll need to manually edit the file solrconfig.xml and remove three lines.

        <useCompoundFile>false</useCompoundFile>
        <ramBufferSizeMB>32</ramBufferSizeMB>
        <mergeFactor>10</mergeFactor>

* Drupal module path: "[docroot]/sites/all/modules/apachesolr"

## Scripts

1. Uncomment ``utils::scripts``` recipe from the run list.
2. Copy the "mis_vagrant" directory from the mis_example repo into your sites
   directory.
3. Edit the post-up.sh and post-install.sh scripts with commands that you will
   need to run.

        Note use the misVagrantAdapter::execute() method when executing scripts
        so that proper script termination is used so that Vagrant/Chef will be
        notified if the command fails.

        Note all configs associated with Vagrant/Chef are compiled in the
        misVagrantAdapter::config object.

4. It may be necessary to specify the location of these scripts. You may do so
   by overriding the ```scripts_path``` attribute for the scripts recipe. The
   default is currently ```sites/all/mis_vagrant```.

**Optional**

1. When ```vagrant up``` is ran the very first time the "post-install.sh" script
   will run, while, "post-up.sh" will run everytime the provision is ran
   (Yes even vagrant up).
2. I also recommend setting up a drush shell alias so that people can run the
   post-up.sh script at will. You may do this by adding the following shell alias
   to your drush_rc file.

        'shell-aliases' => array(
          'post-up' => '!sites/all/mis_vagrant/post-up.sh',
        ),

   With the above shell-alias in place users my execute ```drush @example.mcdev post-up```
   and the post-up script will execute on the guest machine.


## Varnish

1. Uncomment ```utils::varnish``` recipe from the run list.
2. Set the following variables in your settings.php


        /**
         * Varnish settings.
         */
        $conf['reverse_proxy'] = TRUE;
        // Include in this array all webheads, load balancers, and 127.0.0.1.
        $conf['reverse_proxy_addresses'] = array('127.0.0.1');

        // Varnish control terminal.
        // Usually the internal IP of all webheads on port 6082 space separated.
        $conf['varnish_control_terminal'] = '127.0.0.1:6082';
        $conf['varnish_control_key'] = '44cc6ff6-75b1-4187-9637-045ccf41653b';
        $conf['varnish_version'] = '3';
        // Drupal 7 does not cache pages when we invoke hooks during bootstrap. This
        // needs to be disabled.
        $conf['cache_backends'][] = 'sites/all/modules/varnish/varnish.cache.inc';
        $conf['cache_class_cache_page'] = 'VarnishCache';
        $conf['page_cache_invoke_hooks'] = FALSE;


3. Visit your site using http://<host>:6081
