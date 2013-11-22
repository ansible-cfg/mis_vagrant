name             "utils"
maintainer       "Mediacurrent"
maintainer_email "jonathan.delaigle@mediacurrent.com"
license          "All rights reserved"
description      "Installs/Configures various utilities"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"
depends          "varnish"
recipe           "utils", "Installs/Configures various utilities."
recipe           "utils::varnish", "Installs and configures Varnish."