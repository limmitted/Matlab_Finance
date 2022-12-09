function ll = LL_ARMA11 (prmvec, y)

  % usage: ll = loglikelihoodarma11 (parameter_vector, y)
  %
  % calculates the log likelihood of the AR(1) for given
  % intercept 'alpha', MA coefficient 'theta' and standard deviation 'sigma'
  % input parameter_vector = [alpha, phi, theta, sigma, BoxJenkins]
  % if parameter_vector has only four inputs, the likelihood defaults to 
  % Box-Jenkins' suggestion

  % Andreas Pick - Oct 2022
  
  alpha_ = prmvec(1);
  phi_ = prmvec(2);
  theta_ = prmvec(3);
  sig2_ = prmvec(4).^2;
  if length(prmvec) == 5
    BoxJenkins = prmvec(5);
  else
    BoxJenkins = 0;
  end

  T = length(y);

  ep = zeros(T,1);
  if BoxJenkins == 0
    y(1) = alpha_/(1-phi_);
  end
  for t = 2:T
    ep(t) = y(t) - alpha_ - phi_*y(t-1) - theta_*ep(t-1);
  end

  ll = - (T-1)/2*log(2*pi) - (T-1)/2*log(sig2_) - sum(ep.^2)/(2*sig2_);
  ll = -ll; 

end