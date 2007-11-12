#!perl
package Tie::Handle::TtyRec;
use strict;
use warnings;
use parent 'Tie::Handle';

use Symbol;
use Time::HiRes 'gettimeofday';
use Carp 'croak';

sub new {
    my ($class, $filename) = @_;
    my $symbol = Symbol::gensym;

    tie(*$symbol, __PACKAGE__, $filename);

    return $symbol;
}

sub TIEHANDLE {
    my ($class, $filename) = @_;

    open(my $self, '>', $filename) or croak "Unable to open $filename for writing: $!";

    bless $self, (ref $class || $class);
}

sub READ {
    croak "Cannot read from a Tie::Handle::TtyRec::Write";
}

sub PRINT {
    my $self = shift;
    print {$self} map {pack('VVV', gettimeofday, length) . $_} @_;
}

sub CLOSE {
    my $self = shift;
    close $self;
}

=head1 NAME

Tie::Handle::TtyRec - easily create ttyrecs

=head1 VERSION

Version 0.01 released ???

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use Tie::Handle::TtyRec;
    do_stuff();

=head1 DESCRIPTION



=head1 SEE ALSO

L<Foo::Bar>

=head1 AUTHOR

Shawn M Moore, C<< <sartak at gmail.com> >>

=head1 BUGS

No known bugs.

Please report any bugs through RT: email
C<bug-tie-handle-ttyrec at rt.cpan.org>, or browse to
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tie-Handle-TtyRec>.

=head1 SUPPORT

You can find this documentation for this module with the perldoc command.

    perldoc Tie::Handle::TtyRec

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tie-Handle-TtyRec>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tie-Handle-TtyRec>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tie-Handle-TtyRec>

=item * Search CPAN

L<http://search.cpan.org/dist/Tie-Handle-TtyRec>

=back

=head1 COPYRIGHT AND LICENSE

Copyright 2007 Shawn M Moore.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;

