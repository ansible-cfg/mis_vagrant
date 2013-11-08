template "#{node['php']['ext_conf_dir']}/apc.ini" do
  source "apc.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(:name => "apc", :extensions => ["apc.so"], :directives => {

    # Setup only shows overridden defaults. Please review the documentation.
    # http://php.net/manual/en/apc.configuration.php

    'enabled'               =>    1,

    # Min memory 64M for a Drupal install. Review and adjust periodically the
    # first few days and then every few months or whenever dev changes are made. 
    'shm_size'              =>    '128M',
    'shm_segments'          =>    1,

    # On production set stat to 0 for the best performance so APC doesn't check
    # the file before caching it. While in active dev setting to 1 may be better.
    'stat'                  =>    1,

    # Default 1 but if you want to use apc.filters set to 0. 
    'cache_by_default'      =>    1,

    # Filter files, only used if apc.cache_by_default is disabled. Uses posix
    # expression for files to include/ignore based on + and - signs, minus is
    # the default. Uses comma separated file names and not absolute paths. e.g.
    # Cache all files in "drupal-docroot" and ignore "apc.php" files.
    #'filters'               => "+drupal-docroot,apc.php",

    # Number of source files to be cached, review apc.php stats + adjust over time.
    'num_files_hint'        => 8000, # default is 1000.
    'user_entries_hint'     => 8000, # default is 4096.

    # Idle cache entry lifetime in seconds, 7200 = 2hrs.
    # Setting ttl to live to 0 means forever and an apache restart would be
    # needed after each code update to clear the caches.
    'ttl'                   =>    14400,
    'user_ttl'              =>    600,
    'gc_ttl'                =>    600,

    # Defaults to 1M, if you profile you should note any heavy files.
    'max_file_size'         =>    '2M',

    # Enable upload progress, useful in Drupal.
    'rfc1867'               => 1,

    # Determine if your mmap'ed memory region is going to be file-backed or shared
    # memory backed. Option 1 is the default but Option 2 is the most common. @see
    # http://www.php.net/manual/en/apc.configuration.php#ini.apc.mmap-file-mask.
    #
    # Option 1 (default if not set)
    # To mmap directly from /dev/zero, use:
    # 'mmap_file_mask'       => '/dev/zero',
    # 
    # Option 2 (most common)
    # Specify the location for file-backed memory storage file.
    'mmap_file_mask'        => '/tmp/apc.XXXXXX',
    #
    # Option 3
    # For POSIX-compliant shared-memory-backed mmap, use:
    #'mmap_file_mask'        => '/apc.shm.XXXXXX',

  })
  action action
end
