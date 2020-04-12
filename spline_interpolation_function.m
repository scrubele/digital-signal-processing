%x = [0.7 0.9 1.1 1.3 1.5 1.7];
%y = [0.4 0.8 1.2 1.4 1.6 1.8];
x = [0.1 0.2 0.3 0.4 0.5 0.6];
y = [0.2 0.4 0.6 0.8 1.0 1.4];
h = 0.1;
N = 6;

apply_spline_interpolation(x, y, N,h);
create_spline_interpolation_function(x, y, h, N);


function apply_spline_interpolation(x, y, N,h)
    x = x(1: N);
    y = y(1: N);    
    interp = interp1(x,y,x,'spline');
    figure(1);
    plot(x,y,'o',x,interp);
    grid;
end

function create_spline_interpolation_function(x, y, h, N)
    equation_system = create_equation_system(x, y, N, h);
    fprintf('The system of equations is:\n');
    disp(equation_system);
    y_derivative = solve_equation_by_cramers_rule(equation_system, N-1);
    disp(['Y second derivative: [' num2str(y_derivative(:).') ']']);
    coefficient_matrix = find_coefficient(y, N-1, h, y_derivative);
    display_polynomial(coefficient_matrix, x,y, N-2, h);
end

function p = create_equation_system(x, y, N, h)
   for i = 2:1:N-1
        row = zeros(1, N);
        row(i-1: i+1) = [h, 4*h, h];
        row(N) = (-6*h) .* (y(i)-y(i-1))+(6*h )* (y(i+1)-y(i));
        %row(N) = -0.6*(y(i)-y(i-1)) + 0.6*(y(i+1)-y(i));
        p(i-1, :) = row(2:N);
    end
end

function determinant_array = solve_equation_by_cramers_rule(equation_system, N)
  % Ax = B
    A = equation_system(:, [1:N-1]);
    B = equation_system(:, N);
    n = size(A);
    for i = 1:n(1)
        aux = A;
        aux(:, i) = B;
        determinant_array(i) = det(aux)/det(A);
    end
    determinant_array = [0 (determinant_array) 0];
end

function coefficient_matrix = find_coefficient(y, N, h, y_derivative)
   for i = 1:1: N
        row = zeros(1, 4);
        row(1) = y(i);
        row(2) = (1/h) .* (y(i+1)-y(i))-(h/6) .* (y_derivative(i+1)+2 .* y_derivative(i));
        row(3) = y_derivative(i)/2;
        row(4) = (y_derivative(i+1)-y_derivative(i))/(6*h);
        coefficient_matrix(i, :) = row;
        fprintf('P%d(x): a=%.4f, b=%.4f, c=%.4f, d=%.4f \n', i, coefficient_matrix(i, : ));
    end
end

function display_polynomial(coefficient_matrix, x,y, N,h)
    figure(3);
    plot(x,y)
    hold on
    for i = 1:1: N
        current_x = (i*h): .01: ((i+1)*h);
        polinomial = coefficient_matrix(i,1) + coefficient_matrix(i,2)*(current_x - x(i)) + coefficient_matrix(i,3)*((current_x - x(i)).^2) + coefficient_matrix(i,4)*((current_x - x(i)).^3);
        plot(current_x, polinomial);
        hold on
    end
    hold off
    grid;

end
