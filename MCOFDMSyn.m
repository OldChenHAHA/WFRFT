function [CPStartPoint,FCO] = MCOFDMSyn(data, NFFT)
%MLOFDMSYN MC estimation of time and frequency offset in OFDM systems
%   Detailed explanation goes here

%   Authors: Neil Judson
%   Copyright 2016 Neil Judson
%   $Revision: 1.1 $  $Date: 2016/07/29 13:40:00 $

%% 时延
dataDelay = data;
data = [dataDelay(NFFT+1:end) zeros(1,NFFT)];

%% 自相关、能量
selfMult = dataDelay .* conj(data);
gammaLength = length(selfMult) - NFFT;
%gammaLength = 500;
gamma = zeros(1,gammaLength);
for n = 1:1:gammaLength
    gamma(n) = sum(selfMult(n:n+31));
end

target = abs(gamma);
CPStartPoint = find(target==max(target));
CPStartPoint = CPStartPoint(1); % CP起始位置

%% 小数频偏估计
FCO = (-1/2/pi)*angle(gamma(CPStartPoint));

end