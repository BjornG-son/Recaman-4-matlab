figure('Name','Recaman-sequence-plots','position',[25, 174, 742, 718])
try
  colormap(turbo)
catch
  colormap(jet)
end
subplot(3,1,1)
Recaman_seq(32^1,1);
title('Recaman-sequence n: 32','fontsize',12)
subplot(3,1,2)
Recaman_seq(32^2,1);
title('Recaman-sequence n: 1024','fontsize',12)
subplot(3,1,3)
Recaman_seq(32^3,1);
title('Recaman-sequence n: 32768','fontsize',12)
