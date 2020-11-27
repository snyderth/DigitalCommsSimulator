%% compute_ifft
% @descript Computes the full inverse fourier transform using decimation in
% time
% @param H The frequency response
% @param samples the number of samples to take in H
% @retval The time-domain signal
function h = compute_ifft(H, samples)
h = conj((1/samples) * myfft(conj(H),samples));
%% h = scrambled H
% Recall h is the index bit-reversed version of the original indeces
indeces = 0:1:samples-1;
indeces = de2bi(indeces);
indeces = flip(indeces,2);
indeces = bi2de(indeces);

[isort, iorder] = sort(indeces);
h = h(:,iorder);
end