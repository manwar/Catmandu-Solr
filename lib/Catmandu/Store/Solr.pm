package Catmandu::Store::Solr;

use Catmandu::Sane;
use Moo;
use WebService::Solr;

with 'Catmandu::Store';

=head1 NAME

Catmandu::Store::Solr - A searchable store backed by Solr

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use Catmandu::Store::Solr;

    my $store = Catmandu::Store::Solr->new(url => 'http://localhost:8983/solr' );

    my $obj1 = $store->bag->add({ name => 'Patrick' });

    printf "obj1 stored as %s\n" , $obj1->{_id};

    # Force an id in the store
    my $obj2 = $store->bag->add({ _id => 'test123' , name => 'Nicolas' });

    # Commit all changes
    $store->bag->commit;

    my $obj3 = $store->bag->get('test123');

    $store->bag->delete('test123');

    $store->bag->delete_all;

    # All bags are iterators
    $store->bag->each(sub { ... });
    $store->bag->take(10)->each(sub { ... });

    # Some stores can be searched
    my $hits = $store->bag->search(query => 'name:Patrick');

=cut

has url => (is => 'ro', default => sub { 'http://localhost:8983/solr' });

has solr => (
    is      => 'ro',
    lazy    => 1,
    builder => '_build_solr',
);

sub _build_solr {
    WebService::Solr->new($_[0]->url, {autocommit => 0, default_params => {wt => 'json'}});
}

=head1 SEE ALSO

L<Catmandu::Store>

=head1 AUTHOR

Patrick Hochstenbach, C<< <patrick.hochstenbach at ugent.be> >>
Nicolas Steenlant, C<< <nicolas.steenlant at ugent.be> >>

=head1 LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
