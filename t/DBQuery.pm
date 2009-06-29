package t::DBQuery;

use Test::Base -Base;
use IPC::Run3 (); 
use FindBin;

our @EXPORT = qw( run_tests );

$ENV{LC_ALL} = 'C';

sub run_tests ()
{
    for my $block (blocks())
	{
        run_test($block);
    }
}

sub run_test ($)
{
}

1;
