y_arr = [2 3 4 6 7 11];
V = 16;
x_arr = [];
for i = 1:1:6
    x_arr = [x_arr 0.1*V*i];
end
 
x2 = x_arr .^ 2;
ln_y = log(y_arr);
x_ln_y = x_arr .* ln_y;
 
sum_x = sum(x_arr);
fprintf('sum x = %.3f\n', sum_x); 
sum_x2 = sum(x2);
fprintf('sum x^2 = %.3f\n', sum_x2); 
sum_ln_y = sum(ln_y);
fprintf('sum ln(y) = %.3f\n', sum_ln_y); 
sum_x_ln_y = sum(x_ln_y);
fprintf('sum x*ln(y) = %.3f\n', sum_x_ln_y); 
 
B = (sum_x_ln_y - sum_x * sum_ln_y / N) / (sum_x2 - sum_x * sum_x / N);
fprintf('B = %.4f\n', B); 
A = (sum_ln_y - B * sum_x) / N;
fprintf('A = %.4f\n', A); 
 
fprintf('f(x) = e^(%.4f%+.4f*x)\n', A, B); 
 
x = 1.6:9.6;
y = exp(A+B*x);
plot(x, y)
 
hold on
plot (x_arr, y_arr);
hold off
 
s_list = [];
for v = 1:1:N
    x = (A + B * x_arr(v)) - log(y_arr(v));
    s_list = [s_list, x];
end
e = sum(s_list)^2;
 
fprintf('error = ');
disp(e);
