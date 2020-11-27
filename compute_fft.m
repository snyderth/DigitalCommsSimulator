function H = compute_fft(h, samples)

H = myfft(h,samples);
%% h = scrambled H
% Recall h is the index bit-reversed version of the original indeces
indeces = 0:1:samples-1;
indeces = de2bi(indeces);
indeces = flip(indeces,2);
indeces = bi2de(indeces);

[isort, iorder] = sort(indeces);
H = H(:,iorder);

end