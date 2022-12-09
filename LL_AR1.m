
function ll = LL_AR1(prmvec, y)
  alpha = prmvec(1);
  phi_ = prmvec(2);
  sig_2 = prmvec(3).^2;
  T = length(y);
  ydm2 = (y(2:end) - alpha - phi_.*y(1:end-1)).^2;
  ll = - 1/2*log(2*pi)  - 1/2*log(sig_2/(1-phi_^2)) - (y(1) - alpha/(1-phi_))^2/(2*sig_2/(1-phi_^2)) - (T-1)/2*log(2*pi) - (T-1)/2*log(sig_2) - sum(ydm2)/(2*sig_2);
  ll = -ll; % negative loglikelihood to maximize (Matlab minizes 
end
