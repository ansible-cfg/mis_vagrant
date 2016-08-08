Drupal Apachesolr
=========

Apply Drupal Apachesolr module configuration to a Solr server.

Requirements
------------

Depends on a working Solr installation.

Role Variables
--------------

drupal_apachesolr_solr_conf: "solr-3.x"

Dependencies
------------

Depends on the geerlingguy.solr role.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: joestewart.drupal-apachesolr }

License
-------

BSD

Author Information
------------------

This role was created in 2015 by Joe Stewart
