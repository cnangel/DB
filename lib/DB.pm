package DB;

use DBI;

$DB::VERSION = 0.004;

sub new
{
	my $class = shift;
	my $DB = shift;
	my $self;
	if (defined $DB->{dsn})
	{
		$self = {
			'dsn' => $DB->{dsn},
			'user' => $DB->{db_user},
			'pass' => $DB->{db_pass},
			'dbh' => undef,
			'sth' => undef,
		};
	}
	else
	{
		$DB->{driver_name} = 'mysql' unless (defined $DB->{driver_name});
		$DB->{driver_name} = ucfirst($DB->{driver_name}) if ($DB->{driver_name} eq "oracle");
#	$DB->{db_port} = 3306 unless (defined $DB->{db_port});
#	$DB->{db_sock} = '/tmp/mysql.sock' unless (defined $DB->{db_sock});
		$self = {
			'dsn' => $DB->{driver_name} eq 'mysql'
				? 'dbi:' . $DB->{driver_name} . ':database=' . $DB->{db_name} . ';hostname=' . $DB->{db_host} . ';' . (defined $DB->{db_sock} ? 'mysql_socket=' . $DB->{db_sock} . ';' : 'mysql_socket=/tmp/mysql.sock;') . (defined $DB->{db_port} ? 'port=' . $DB->{db_port} : 'port=3306') 
				: ($DB->{driver_name} eq 'pgsql' 
						? 'dbi:' . $DB->{driver_name} . ':dbname=' . $DB->{db_name} . ';' . (defined $DB->{db_host} ? 'host=' . $DB->{db_host} . ';' : '') . (defined $DB->{db_path} ? 'path=' . $DB->{db_path} . ';' : '') . (defined $DB->{db_port} ? 'port=' . $DB->{db_port} : 'port=5432')
						: 'dbi:' . $DB->{driver_name} . (defined $DB->{db_host} ? ':' . $DB->{db_host} : '')
				  ),
			'user' => $DB->{db_user},
			'pass' => $DB->{db_pass},
			'dbh' => undef,
			'sth' => undef,
		};
	}
	bless $self, $class;
	return $self;
}

sub connect
{
	my $self = shift;
	$self->{dbh} = DBI->connect($self->{dsn}, $self->{user}, $self->{pass}, {'RaiseError' => 1});
	return;
}

sub query
{
	my $self = shift;
	$self->{sth} = $self->{dbh}->prepare($_[0]);
	$self->{sth}->execute();
	return $self->{sth};
}

sub quote
{
	my $self = shift;
	return $self->{dbh}->quote($_[0]);
}

sub fetch_array
{
	my $self = shift;
	return ref($_[0]) eq 'DBI::st' ? $_[0]->fetchrow_array() : $self->{sth}->fetchrow_array();
}

sub fetch_hash
{
	my $self = shift;
	return ref($_[0]) eq 'DBI::st' ? $_[0]->fetchrow_hashref() : $self->{sth}->fetchrow_hashref();
}

sub close
{
	my $self = shift;
	$self->{sth}->finish() if (defined $self->{sth});
	$self->{dbh}->disconnect if (defined $self->{dbh});
	return;
}

1;

__END__

=head1 NAME

DB.pm  - Lib of DB Query

=head1 SYNOPSIS

use DB;

=head1 OPTIONS

=over 8

=item B<Struct Init>

Mysql example:

my %DB = (
		'db_host'	=> 'web10.search.cnb.yahoo.com',
		'db_user'	=> 'yahoo',
		'db_pass'	=> 'yahoo',
		'db_name'	=> 'ADCode',
		);

my $db = new DB(\%DB);

or postgresql example:

my %PQ = (
		'driver_name'	=> 'PgPP',
		'db_host'		=> 'tool2.search.cnb.yahoo.com',
		'db_name'		=> 'cnedb',
		'db_user'		=> 'cnedb',
		'db_pass'		=> 'cnedb',
		);

or oracle example:

my %OC = (
		'driver_name'	=> 'oracle',
		'db_host'		=> 'ocndb',
		'db_user'		=> 'alibaba',
		'db_pass'		=> 'ocndb',
		);

my $db = new DB(\%OC);

over this, you can use dsn for init structure.

my %DB = (
		'dsn'			=> 'dbi:mysql:database=testinter;host=localhost;mysql_socket=/var/lib/mysql/mysql.sock',
		'db_user'       => 'pca',
		'db_pass'       => 'pca',
		);

it yet run.

=item B<Connect>


$db->connect();

You can unset the variable: %DB, %PQ or $OC, like this:

undef %PQ;
or 
undef %DB;
or
undef %OC;

=item B<Query>


Simple:

$db->query("select url from edb.white_black_grey where spamtype=':demote2:' limit 10;");

while (my $row = $db->fetch_array())
{
	print $row, "\n";
}

Common:

my $query = $db->query("select url from edb.white_black_grey where spamtype=':demote2:' limit 10;");

while (my $row = $db->fetch_array($query))
{
	print $row, "\n";
}

=item B<Disconnect>


$db->close();

=back

=head1 DESCRIPTION

B<This lib> will query some information from some different type databases, you can use it very expediently. so we use database easily.

B<This lib> can use dsn which contains all connection infomation or use all single items, like db_host, db_pass etc.

=head1 AUTHOR 

B<Cnangel> (I<junliang.li@alibaba-inc.com>)

=head1 HISTORY

I<Thu Nov  8 13:53:42 2007> B<v0.001> Build.

I<Wed Jan  2 14:54:48 2008> B<v0.002> Build and add postgresql query.

I<Fri Jan 18 15:31:57 2008> B<v0.002> Update.

I<Tue Jun 16 14:52:22 2009> B<v0.003> Build and add oracle query function.

I<Wed Jun 17 10:01:32 2009> B<v0.004> Could use uri which contains connection infomation for databases. 

=cut

