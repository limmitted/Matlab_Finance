% based on Economic Forecasting Author(s): Graham Elliott, Allan Timmermann  Publisher: Princeton University Press, Year: 2016  ISBN: 978-0-691-14013-1
%MA(1) model
clear; clc;
%cd '..
format longG
%MA(1): two methods: ll, package 

randn('seed',12345) % seed random number generator



options = optimset('Display','off','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30); % details for Matlab's optimization function


% --- Generating data via German DAX stock returns DAX PERFORMANCE-INDEX
% (^GDAXI) (09.12.21-09.12.22)

% ---
data  = readtable('^GDAXI(1).csv');
data=data.Open
y=data(1:end-1) ./ data(2:end) -1 % create returns

hY1 = adftest(y,Model="ts",Lags=2) %1 stationarity test: indicates that there is sufficient evidence to suggest that y is trend stationary.


T=length(y)
% MA 1 model
loglik = nan(3,1); % reserve memory for log likelihood values for different models
beta0 = [0.5;0.5;0.5];  % starting values for the ML estimation
[bhatAR, loglik(1)] = fminunc('LL_MA1',beta0,options,y);  % ML estimation

disp('MA ML parameter estimates')
disp(bhatAR)

disp('MA Matlab package parameter estimates')
model_ar = ar(y,1);
Mdl = arima(0,0,1);
EstMdl = estimate(Mdl,y);
disp(EstMdl.Constant)


