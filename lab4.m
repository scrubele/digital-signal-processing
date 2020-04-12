N = 3;
k = [1, 2, 3];
fa = 4200;
fg = 800;

main(k, N, fa, fg)

function main(k, N, fa, fg)
    a = find_a_coefitients(k, N, fa, fg);
    a_pos = find_a_positive(N,a);
    
    find_amp_freq_characteristics(N, a_pos);
    [eVyh, eW, h, t, a, b] =find_transient_characteristics(N, a_pos);
    find_a_loss(h, t, eVyh, eW);
    find_filter(N, a,b);
end

function a = find_a_coefitients(k, N, fa, fg)
    a = []
    for i= 1:1:N
        % g = k(i)*(fg/fa)
        % l = 2*pi*k(i)*(fg/fa)
        % sin_k = sin(l)
        chyselnyk = (2*fg/fa)*(sin(2*pi*k(i)*(fg/fa)))
        znamennyk = (2*pi*k(i)*(fg/fa))
        a(i) = chyselnyk/znamennyk;
        fprintf('а%d = %.4f\n', i, a(i));
            
    end
end

function a_pos = find_a_positive(N,a)
    a_pos = [];
    for i=1:1:N
        if (a(i)>0)
              a_pos = [a_pos a(i)];
        end
    end
    a_pos = fliplr(a_pos);
end

function find_amp_freq_characteristics(N, a_pos)
    %АЧХ та ФЧХ
    b = fir1(N, a_pos, 'low');
    figure();
    freqz(b, 1, 512);
end

function [eVyh, eW, h, t, a,  b] = find_transient_characteristics(N, a_pos)
    %Перехідна ІХ
    [a,b] = fir1(N, a_pos, 'low');
    [h,t] = impz(a,b);
    figure();
    stem(t, h);
    disp(a);
    eVyh = 0.1/2*sum(b);
    eW = max(a-b);
end

function temp = find_x_2(h, t)
    temp =[];
    % find X2n 
    for x = h 
        for y = t
            t1 = t;
        end
        x1 = x; 
        k = 0;
        l = x1.*t1;
        if l < 1
            k = l;
        end
        temp = [temp , k];
    end 
end

function find_a_loss(h, t, eVyh, eW)
    temp = find_x_2(h, t);
    eOk = 0.1/2*(sum(temp));
    e = sqrt(eVyh.^2 + eW.^2 + eOk.^2);
    fprintf('pohybka =%.4f', e);
end

function find_filter(N, a,b)
    N = 6;  
    T = 2 * pi / N; 
    w = (2 * pi) / T; 
    t = 0:.01:T;
    x = 2.7-0.5*cos(w*t)+0.6*cos(2*w*t)+1.0*cos(3*w*t)-1.4434*sin(w*t)-0.1155*sin(2*w*t)-0.0000*sin(3*w*t);
    y = filter(a, b, x);
    figure();
    hold on
    stem(t, x);
    stem(t, y);
    hold off
end


