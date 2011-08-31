# Shipping calculator for Sri Lanka Registered Mail #

This is weight based Shipping calculator for Sri Lanka Registered Mail Service for [Spree projects](http://spreecommerce.com)

## Installation & Configuration ##

Add to your gemfile

gem "spree_srilanka_postal_service",  :git => "git://github.com/pmisters/spree_srilanka_postal_service.git"

Go to admin interface

http://localhost:3000/admin/shipping_methods/new

and use "Sri Lanka Registered Mail" as calculator.

The size/weight "table" must have the same amount of (space separated) entries.

Optionally add your own locale to config/locales/  (and if you do, send it to me)