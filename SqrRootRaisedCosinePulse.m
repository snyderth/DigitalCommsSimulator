%% NOTE: Run "Simulator.m" in matlab for the full simulator
% @fn SqrRootRaisedCosinePulse
% @descript Generates a pulse to pulse shape the signal.
%       NOTE: This uses the square-root-raised cosine pulse.
% @param N Number of samples to take from the pulse
% @param beta Beta in the square-root-raised cosine pulse
% @param T Inverse of the information rate (seconds per sample transmitted)
% @retval H An array. Contains pulse shape.
function H = SqrRootRaisedCosinePulse(N, beta, T)
    H = zeros(1,N); % Make a row vector
    w = zeros(1,N); % Hold frequency values
    % Generate the frequencies to compute on
    start = -N/2;
    ending= N/2-1;
    timescale = start:1:ending;
%     for K = timescale
%        w(1, K+N/2+1) = 2 * pi * K / N; 
%     end
    % Compute the pulse
    for K = timescale
        w = 2 * pi * K / N;
        if(abs(w) <= (pi * (1 - beta) / T))
            H(1,K+1+N/2) = sqrt(T);
        elseif(abs(w) <= pi * (1 + beta) / T)
            betaFraction = (1-beta) * pi / T;
            cosineVal = cos((T / (2 * beta)) * (abs(w)-betaFraction));
            H(1,K+1+N/2) = sqrt((T/2) * (1 + cosineVal));
        else
            H(1,K+1+N/2) = 0;
        end
    end
end