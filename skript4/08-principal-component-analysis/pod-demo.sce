// Mit rechter Maustaste Datenpunkte hinzufügen.
// Mit linker Maustaste Vorgang abschließen.
// Das Programm zeichnet dann die beiden POD-Basisvektoren ein,
// gewichtet gemäß des zugehörigen Singulärwerts.

ps = zeros(2,0);

clf;
plot2d([-1,1], [0,0],  rect=[-1,-1,1,1]);
plot2d([0,0],  [-1,1], rect=[-1,-1,1,1]);

while %T
  adds = locate(-1, flag=1);
  if(size(adds,2) == 0) break; end;
  ps = [ps, adds];
  clf;
  plot2d([-1,1], [0,0],  rect=[-1,-1,1,1]);
  plot2d([0,0],  [-1,1], rect=[-1,-1,1,1]);
  plot2d(ps(1,:), ps(2,:), rect=[-1,-1,1,1], style=-1);
  [U,S,V] = svd(ps);
  for i = 1:2
    plot2d([0,U(1,i)*S(i,i)/S(1,1)],[0,U(2,i)*S(i,i)/S(1,1)], style=1+i);
  end;
end
clf;
