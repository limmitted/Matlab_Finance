% based on Economic Forecasting Author(s): Graham Elliott, Allan Timmermann  Publisher: Princeton University Press, Year: 2016  ISBN: 978-0-691-14013-1
%AR(1) model
clear; clc;
%cd '...
format longG
%AR(1): three methods: ll, package ar, OLS
% log likelihood
randn('seed',12345) % seed random number generator

T = 5000;

options = optimset('Display','off','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30); % details for Matlab's optimization function

% --- Generating data from ARMA(1,1) via burn in period of 10:
alpha = 1;    % intercept
phi = 0.6;    % AR coefficient
theta = 0;    % MA coefficient
sigma = 1;    % std. dev. of errors
preSample = 10;
y = zeros(T+preSample,1); % add presample of 10 observations
y(1) = alpha/(1-phi);
err = randn(T+preSample,1)*sigma;
for t = 2:T+preSample
    y(t) = alpha + phi*y(t-1) + err(t) + err(t-1)*theta;
end
y = y(preSample+1:end);

% ---
% --- Generating data via German DAX stock returns DAX PERFORMANCE-INDEX
% (^GDAXI) (09.12.21-09.12.22)

% ---
data  = readtable('^GDAXI(1).csv');
data=data.Open
y=data(1:end-1) ./ data(2:end) -1 % create returns

hY1 = adftest(y,Model="ts",Lags=2) %1 stationarity test: indicates that there is sufficient evidence to suggest that y is trend stationary.


T=length(y)
% AR 1 model
loglik = nan(3,1); % reserve memory for log likelihood values for different models
beta0 = [0.5;0.5;0.5];  % starting values for the ML estimation
[bhatAR, loglik(1)] = fminunc('LL_AR1',beta0,options,y);  % ML estimation

disp('AR ML parameter estimates')
disp(bhatAR)
btilde = [ones(T-1,1) y(1:end-1)]\y(2:end); % miss out on distribution of first one 
disp('AR OLS parameter estimates')
disp(btilde)  % since AR(1) is essentially least squares in this case 

disp('AR Matlab package parameter estimates')
model_ar = ar(y,1);
Mdl = arima(1,0,0);
EstMdl = estimate(Mdl,y);
disp(EstMdl.Constant)


