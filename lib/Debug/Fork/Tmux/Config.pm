#
# This file is part of Debug-Fork-Tmux
#
# This software is Copyright (c) 2012 by Peter Vereshagin.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
# ABSTRACT: Configuration system for Debug::Fork::Tmux
package Debug::Fork::Tmux::Config;

# Helps you to behave
use strict;
use warnings;

our $VERSION = '1.000009';    # VERSION
#
### MODULES ###
#
# Glues up path components
use File::Spec;

# Resolves up symlinks
use Cwd;

# Dioes in a nicer way
use Carp;

# Makes constants possible
use Const::Fast;

### CONSTANTS ###
#

# Default path to the 'tmux' binary
# Requires  :   Cwd
const my $_DEFAULT_TMUX_PATH => Cwd::realpath('/usr/local/bin');

# Default 'tmux' binary fqdn
# Depends   :   On $_DEFAULT_TMUX_PATH
# Requires  :   File::Spec
const my $_DEFAULT_TMUX_FQDN =>
    File::Spec->catfile( $_DEFAULT_TMUX_PATH => 'tmux' );

# Keep the configuration variables
my %_CONF;

# Tmux file name with full path
$_CONF{'tmux_fqdn'} = $_DEFAULT_TMUX_FQDN;

# Tmux 'neww' parameter for a system/shell command
$_CONF{'tmux_cmd_neww_exec'} = 'sleep 1000000';

# Tmux  'neww' command paraneters to be sprintf()'d with 'tmux_fqdn' and
# pushed after split by spaces the 'tmux_cmd_neww_exec' into list of
# parameters
$_CONF{'tmux_cmd_neww'} = "neww -P";

# Tmux command parameters to get a tty name
$_CONF{'tmux_cmd_tty'} = 'lsp -F #{pane_tty} -t';

# Take config override from %ENV
# Depends   :   On %ENV global of the main::
foreach my $key ( keys %_CONF ) {

    # Key for %ENV
    my $env_key = "SPUNGE_" . uc $key;

    next unless defined $ENV{$env_key};

    $_CONF{$key} = $ENV{$env_key};
}

const %_CONF => %_CONF;

### ATTRIBUTES ###
#

### SUBS ###
#

# Static method
# Returns Str argument configured as a key supplied as an argument
# Takes     :   Str argument to read config for
# Depends   :   On %_CONF package lexical
# Requires  :   Carp
# Throws    :   If no configuration found for an argument
# Returns   :   %_CONF element for an argument
sub get_config {
    shift;
    my $key = shift;

    croak("Undefined in a configuration: $key") unless defined $_CONF{$key};

    return $_CONF{$key};
}

# Static method
# Takes     :   n/a
# Depends   :   On %_CONF package lexical
# Returns   :   Array keys of %_CONF package lexical
sub get_all_config_keys { return keys %_CONF }

# Returns true to require()
1;

__END__

=pod

=head1 NAME

Debug::Fork::Tmux::Config - Configuration system for Debug::Fork::Tmux

=head1 VERSION

This documentation refers to the module contained in the distribution C<Debug-Fork-Tmux> version 1.000009.

=head1 SYNOPSIS

    use Debug::Fork::Tmux;

    my $tmux_fqdn = Debug::Fork::Tmux->config( 'tmux_fqdn' );

=head1 DESCRIPTION

This module reads description from environment variables and use defaults if
those are not set.

For example C<tmux_fqdn> can be overridden with C<SPUNGE_TMUX_FQDN>
variable, and so on..

=head1 SUBROUTINES/METHODS

All of the following are static methods:

=head2 PUBLIC

=head3 C<get_config( Str the name of the option )>

Retrieves configuration stored in an internal C<Debug::Fork::Tmux::Config>
constants.

Returns C<Str> value of the configuration parameter.

=head2 PRIVATE

=head3 C<get_all_config_keys()>

Returns C<Array[Str]> names of all the configuration parameters.

=head1 CONFIGURATION AND ENVIRONMENT

See L<Debug::Fork::Tmux/CONFIGURATION AND ENVIRONMENT>.

=head1 DIAGNOSTICS

=over

=item C<Undefined in a configuration: E<lt>keyE<gt>>

Dies if no key asked was found in the configuration.

=back

=head1 BUGS AND LIMITATIONS

You can make new bug reports, and view existing ones, through the
web interface at L<http://bugs.vereshagin.org/product/Debug-Fork-Tmux>.

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Debug::Fork::Tmux

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<http://metacpan.org/release/Debug-Fork-Tmux>

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/Debug-Fork-Tmux>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Debug-Fork-Tmux>

=item *

AnnoCPAN

The AnnoCPAN is a website that allows community annotations of Perl module documentation.

L<http://annocpan.org/dist/Debug-Fork-Tmux>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/Debug-Fork-Tmux>

=item *

CPAN Forum

The CPAN Forum is a web forum for discussing Perl modules.

L<http://cpanforum.com/dist/Debug-Fork-Tmux>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.perl.org/dist/overview/Debug-Fork-Tmux>

=item *

CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/D/Debug-Fork-Tmux>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=Debug-Fork-Tmux>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=Debug::Fork::Tmux>

=back

=head2 Email

You can email the author of this module at C<peter@vereshagin.org> asking for help with any problems you have.

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<peter@vereshagin.org>, or through
the web interface at L<http://bugs.vereshagin.org/product/Debug-Fork-Tmux>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<http://gitweb.vereshagin.org/Debug-Fork-Tmux>

  git clone https://github.com/petr999/Debug-Fork-Tmux.git

=head1 AUTHOR

L<Peter Vereshagin|http://vereshagin.org> <peter@vereshagin.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by Peter Vereshagin.

This is free software, licensed under:

  The (three-clause) BSD License

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Debug::Fork::Tmux|Debug::Fork::Tmux>

=item *

L<Debug::Fork::Tmux::Config|Debug::Fork::Tmux::Config>

=item *

L<http://perlmonks.org/?node_id=128283|http://perlmonks.org/?node_id=128283>

=back

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT
WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER
PARTIES PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE
SOFTWARE IS WITH YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME
THE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE LIABLE
TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
DAMAGES.

=cut
