function r = correlation_histA_histB(histA,histB)

% A and B correlation 
% r = [(a(i)-a_avg)*(b(i)-b_avg)]/[sqrt(a(i)-a_avg)^2]*[sqrt(b(i)-b_avg)^2]

%example 
%histA = [1:5];
%histB = [5:-1:1];

r = cov(histA,histB)/(std(histA)*std(histB)) % cov(A,B)/std(A)*std(B) 

end


function Main()

frameRateArr = [];
errorRateArr = [];
numOfKeys = 100;

frameHistSize = 20;
errorHistSize = 20;

SumOfFrameRate = 0;
sumOfErrorRate = 0;
sumOfErrorRateTimesFrameRate = 0;

frameRateHist = [];
errorRateHist = [];

for i=1:numOfKeys
    sumOfErrorRateTimesFrameRate = sumOfErrorRateTimesFrameRate + reshape(kron(frameRateHist,errorRateHist),frameHistSize, errorHistSize) ;
    sumOfframeRate = sum(frameRateHist);
    sumOfErrorRate = sum(errorRateHist);
    
    sumOfErrorRateTimesFrameRate = sumOfErrorRateTimesFrameRate %(sumOfErrorRate*sumOfErrorRate)
    
end

