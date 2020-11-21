%% NOTE: Run "Simulator.m" in matlab for the full simulator
% @fn GenerateRandomSequence
% @descript Generates a random sequence of length n of +/- 1
% @param n the length of the signal
% @retval Row vector containing two signals of length n
function [b1, b2] = GenerateRandomSequence(n)
    rng('default'); % Seed
    b1 = normrnd(0, 1, 1, n); % Produce first sequence
    b2 = normrnd(0, 1, 1, n); % Secnod sequence
    b1(b1==0) = 1;
    b2(b2==0) = 1;
    b1 = b1 ./ abs(b1); % Make everything a signed one value
    b2 = b2 ./ abs(b2);
end