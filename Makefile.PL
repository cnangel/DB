use strict;
use lib '.';
use inc::Module::Install;

name                ('DBQuery');
license             ('bsd');
author              ('Cnangel <junliang.li@alibaba-inc.com>');
perl_version        ('5.006001');
all_from            ('lib/DBQuery.pm');

requires            ('DBI'   => '1.6');

#build_requires      ('IPC::Run3');
build_requires      ('Test::Base' => '0.50');

use_test_base;

no_index( directory => qw< t inc > );

#install_script      ('bin/fornodes');
#install_script      ('bin/atnodes');
#install_script      ('bin/tonodes');
#install_script      ('bin/key2nodes');

auto_install();
WriteAll();

=head1 OLD

use 5.010000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'DBQuery',
    VERSION_FROM      => 'lib/DBQuery.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (#ABSTRACT       => 'DBQuery',
       ABSTRACT_FROM  => 'lib/DBQuery.pm', # retrieve abstract from module
       AUTHOR         => 'Cnangel <junliang.li@alibaba-inc.com>') : ()),
);

=cut
