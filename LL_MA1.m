function ll = LL_MA1 (prmvec, y)

  mu = prmvec(1);
  theta = prmvec(2);
  sig2 = prmvec(3).^2;
  T = length(y);
  ep = zeros(T,1);
  ep(1) = y(1) - mu;
  for t = 2:T
    ep(t) = y(t) - mu - theta*ep(t-1);
  end
  ll = - T/2*log(2*pi) - T/2*log(sig2) - sum(ep.^2)/(2*sig2);
  ll = -ll; 
end
