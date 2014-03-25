#!/usr/bin/perl
# Galton-Watson-Simulation mit geometrischer Verteilung

use warnings;
use strict;

use constant NUM_GENERATIONS => $ARGV[0] || 100;
use constant P               => $ARGV[1] || 0.5;

printf STDERR "Aussterbewahrscheinlichkeit: %f\n",
  P <= 0.5 ? P/(1-P()) : 1;

my $population = 1;

for (1..NUM_GENERATIONS) {
  my $new_population = 0;

  for (1..$population) {
    $new_population++ while rand() > P;
  }

  $population = $new_population;
  print "$population\n";
}
