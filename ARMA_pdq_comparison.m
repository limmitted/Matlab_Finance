% based on Economic Forecasting Author(s): Graham Elliott, Allan Timmermann  Publisher: Princeton University Press, Year: 2016  ISBN: 978-0-691-14013-1
%ARMA(p,d,q) model
clear; clc;
%cd ''
format longG


randn('seed',12345) % seed random number generator
options = optimset('Display','off','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30); % details for Matlab's optimization function


% --- Generating data via German DAX stock returns DAX PERFORMANCE-INDEX
% (^GDAXI) (09.12.21-09.12.22)

% ---
data  = readtable('^GDAXI(1).csv');
data=data.Open
y=data(1:end-1) ./ data(2:end) -1 % create returns
hY1 = adftest(y,Model="ts",Lags=2) %1 stationarity test: indicates that there is sufficient evidence to suggest that y is trend stationary.
disp('MA Matlab package parameter estimates')
p_max=5
q_max=3
d_max=5
count = p_max*d_max*q_max
A=zeros(3,count)
i=1
for p =1:p_max
    for q=1:q_max
        for d = 1:d_max
            model_ar = ar(y,1);
            Mdl = arima(p,1,q);
            [EstMdl, logL] = estimate(Mdl,y);
            F=(logL(end,end))
            A(1,i)=F
            A(2,i)=p
            A(3,i)=q
            A(4,i)=d
            disp(EstMdl.Constant);
            i=i+1
        end
    end
end
[mr,mir] = min(A);
[mc,mic] = min(mr);
[mir(mic), mic];
disp("best model in terms of log likelihood is the p=" + A(mir(mic)+1,mic)+ " and q =" + A(mir(mic)+2,mic) + "and d =" + A(mir(mic)+3,mic)   )
Mdl = arima(A(mir(mic)+1,mic),A(mir(mic)+3,mic),A(mir(mic)+2,mic));




