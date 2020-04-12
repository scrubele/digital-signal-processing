y = [2 3 4 6 7 11];
N = 6;
T = 2*pi/N;
w = (2 * pi)/T;
K = round((N-1)/2);


hold on;
t = 0.1:T/6:T;
plot(t, y);
hold off;
 
a0 = (2/N)*sum(y);
fprintf('a0 = %.4f\n', a0);

find_a_coeifitients(K, N, T, y);
find_b_coefitients(K, N, T, y);
f = find_function(a0, a_l, b_l,T,w);
find_error(f,y);

function a_l = find_a_coeifitients(K, N, T, y)
    a_l = [];
    for k = 1:1:K
        a = 0;    
        for n = 1:1:N
            a = a +y(n)*cos(k*T*n);
        end
        a = 2/N * a;
        fprintf('a%i = %.4f\n', k, a); 
        a_l = [a_l, a];
    end
    disp(a_l)
end
function b_l = find_b_coefitients(K, N, T, y)
    b_l = [];

    for k = 1:1:K
        b = 0;    
        for n = 1:1:N
            b = b +y(n)*sin(k*T*n);
        end
        b = 2/N * b;
        fprintf('b%i = %.4f\n', k, b); 
        b_l = [b_l, b];
    end
    disp(b_l)
end

function f=find_function(a0, a_l, b_l,T, w)
    hold on;
    t = 0:.01:6*T;
    f = a0/2+a_l(1)*cos(w*t)+a_l(2)*cos(2*w*t)+a_l(3)*cos(3*w*t)+b_l(1)*sin(w*t)+b_l(2)*sin(2*w*t)+b_l(3)*sin(3*w*t);
    plot(t, f);
    hold off; 
    fprintf('f(t) = %.4f%+.4fcos(wt)%+.4fcos(2wt)%+.4fcos(3wt)%+.4fsin(wt)% +.4fsin(2wt)%+.fsin(3wt)\n', a0/2, a_l, b_l); 
end


function find_error(f,y)
    s_list = [];
    to = 1:1:6;
    for ix=to
        y_new = f(ix);
        x_new = (y_new - y(ix));
        s_list = [s_list, x_new];
    end
    s = min(s_list).^2;
    fprintf('error = %.9f\n', s);
end