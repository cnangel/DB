use strict;
use lib '.';
use inc::Module::Install;

name                ('DB');
license             ('bsd');
author              ('Cnangel <cnangel@126.com>');
perl_version        ('5.006001');
all_from            ('lib/DB.pm');

requires            ('DBI'   => '1.6');

#build_requires      ('IPC::Run3');
build_requires      ('Test::Base' => '0.50');

use_test_base;

no_index( directory => qw< t inc doc share demo > );

#install_script      ('bin/fornodes');
#install_script      ('bin/atnodes');
#install_script      ('bin/tonodes');
#install_script      ('bin/key2nodes');

auto_install();
WriteAll();

