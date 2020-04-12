nTa=[0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];
f=[0, -1,-5,-2,0.7,2,0.2,-0.8,-0.3,0.5]
Ta = 0.1;
fa= 10;
NTa = 1;
N = 10;
fr=[];

fr = find_fr(f, NTa,Ta, fa)
display_results(fr)
bar(fr);

function fr = find_fr(f, NTa,Ta, fa)
    for k=1:1:10
       w=(2*pi*k)/NTa;
       sum_cos=0;
       sum_sin=0;
       for n = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
           sum_cos = sum_cos + f(n + 1) * cos(w * n * Ta);
           sum_sin = sum_sin + f(n + 1) * sin(w * n * Ta);
       end
       fr(k)=Ta*sqrt(sum_cos.^2+sum_sin.^2);
    end
end

function display_results(fr)
    for i=1:1:10
        fprintf('fr%d = %.4f\n', i, fr(i));
    end
end
