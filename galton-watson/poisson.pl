#!/usr/bin/perl
# Galton-Watson-Simulation mit Poisson-Verteilung

use warnings;
use strict;

use constant NUM_GENERATIONS => $ARGV[0] || 100;
use constant LAMBDA          => $ARGV[1] || 1;

my $population = 1;

for (1..NUM_GENERATIONS) {
  my $new_population = 0;

  for (1..$population) {
    $new_population += poisson(LAMBDA);
  }

  $population = $new_population;
  print "$population\n";
}

# Wikipedia, nach Knuth
sub poisson {
  my $lambda = shift;

  my $l = exp(-$lambda);
  my $k = 0;
  my $p = 1;

  do {
    $k++;
    $p = $p * rand();
  } while($p > $l);

  return $k-1;
}
