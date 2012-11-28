use strict;
use lib '.';
use inc::Module::Install;

name                ('DBQuery');
license             ('bsd');
author              ('Cnangel <cnangel@gmail.com>');
perl_version        ('5.006001');
all_from            ('lib/DBQuery.pm');

requires            ('DBI'   => '1.4');

build_requires      ('Test::Base' => '0.10');

use_test_base;

no_index( directory => qw< t inc > );

auto_install();
WriteAll();

