# Development tools

## Webgrind

1. Uncomment ```dev-tools::webgrind``` recipe from the run list.
2. Run a site url with the following query parameter ```?XDEBUG_PROFILE=true```
3. Navigate to the webgrind interface by going to http://webgrind.<host>

## XHPROF

1. Uncomment ```dev-tools::xhprof``` recipe from the run list.
2. Set the following variables in your settings.php (Be sure to replace <host> with your domain.)

```
/**
 * XHPROF settings.
 */
$conf['devel_xhprof_enabled'] = 1;
$conf['devel_xhprof_directory'] = '/usr/share/php';
$conf['devel_xhprof_url'] = 'http://xhprof.<host>';
```

3. Navigate to the xhprof interface by going to http://xhprof.<host>
