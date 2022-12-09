% based on Economic Forecasting Author(s): Graham Elliott, Allan Timmermann  Publisher: Princeton University Press, Year: 2016  ISBN: 978-0-691-14013-1
%ARMA(1,1) model
clear; clc;
cd 'C:\Users\AlexK\OneDrive\Desktop\TimeSeries'
format longG
%ARMA(1,1): two methods: ll, package 

randn('seed',12345) % seed random number generator



options = optimset('Display','off','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30); % details for Matlab's optimization function


% --- Generating data via German DAX stock returns DAX PERFORMANCE-INDEX
% (^GDAXI) (09.12.21-09.12.22)

% ---
data  = readtable('^GDAXI(1).csv');
data=data.Open
y=data(1:end-1) ./ data(2:end) -1 % create returns

hY1 = adftest(y,Model="ts",Lags=2) %1 stationarity test: indicates that there is sufficient evidence to suggest that y is trend stationary.


% comparison autocorrelogram with population 
T=length(y)

%ARMA(1,1) model

  beta0 = [0.4;0.4;0.4;0.4;1];  % starting values for the ML estimation
  [bhatARMA, loglik(3)] = fminunc('LL_ARMA11',beta0,options,y);  % ML estimation
  disp('ARMA parameter estimates')
  disp(bhatARMA(1:4))



disp('ARMA Matlab package parameter estimates')
Mdl = arima(1,0,1);
EstMdl = estimate(Mdl,y);
disp(EstMdl.Constant)


