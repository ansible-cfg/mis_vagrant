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
