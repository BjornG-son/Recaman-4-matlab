function x = Recaman_seq(n,do_plot)
% Recaman_seq - Recaman-sequence-function. 
% The Recaman_seq-function calculates the N first numbers of the Recaman-
% sequence (https://oeis.org/A005132,
% https://en.wikipedia.org/wiki/Recam%C3%A1n%27s_sequence), the Recaman
% sequence is irregular, where the length of the step from one element to
% the next increases by one, the step-direction is down if the
% landing-point is not yet part of the sequence, otherwise up. It is not
% known if every natural number is part of the sequence.
% 
% Calling:
%  x = Recaman_seq(n[,do_plot])
% Input:
%  n - number of terms to calculate, integer scalar
%  do_plot - optional argument, integer scalar to plot the sequence with
%            connected half-circles (or not), defaults to false.
% Output:
%  x - integer array with Recaman-sequence numbers.
% 
% Example:
%  xRecaman = Recaman_seq(96,1);
% 
% If the function cmlines is available half-circles will be coloured in
% sequence.

%   Copyright © 20200404 Bjorn Gustavsson, <bjorn.gustavsson@uit.no>
%   This is free software, licensed under GNU GPL version 2 or later


x=zeros(n,1);

for i1 = 2:numel(x)
  
  p = x(i1-1) - i1+1;
  if (all(x ~= p) && p > 0)
    
    x(i1) = p;
    
  else
    
    x(i1) = x(i1-1)+i1-1;
    
  end
  
end

if nargin > 1 && do_plot
  plot_Recaman(x(:))
end


function plot_Recaman(x)

ih = ishold;
phi = linspace(pi,0,181);

xHWP = ( x(1:end-1) + x(2:end) )/2;
R    = abs( x(2:end) - x(1:end-1) )/2;

x2plot = zeros(181*(numel(xHWP)),1);
y2plot = zeros(181*(numel(xHWP)),1);

for i1 = 1:numel(xHWP)
  x2plot((1:181)+181*(i1-1)) = R(i1)*cos(phi) + xHWP(i1);
  if  xHWP(i1) > x(i1+1)
    x2plot((1:181)+181*(i1-1)) = flipud(x2plot((1:181)+181*(i1-1)));
  end
  y2plot((1:181)+181*(i1-1)) = R(i1)*sin(phi)*(-1)^i1 + 0 ;
end

try
  nArcs = numel(x2plot)/181;
  if nArcs < 1200
    nParts = 181;
  else
    nfacts = factor(numel(x2plot));
    nParts = 181*nfacts(2);
  end
  for i1 = (numel(x2plot)/nParts):-1:1 % numel(xHWP)
    ph(i1) = plot(x2plot((1:nParts)+nParts*(i1-1)),y2plot((1:nParts)+nParts*(i1-1)),'linewidth',2);
    hold on
  end
  cmlines(ph)
catch
  plot(x2plot,y2plot)
end
hold on
plot(0:max(x),0*(0:max(x)),'k.')
if ~ih
  hold off
end
axis equal