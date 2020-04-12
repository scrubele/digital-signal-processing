x = [0.7 0.9 1.1 1.3 1.5 1.7 1.9 2.1];
y = [0.4 0.8 1.2 1.4 1.6 1.8 2.0 2.2];
%x = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8];
%y = [0.2 0.4 0.6 0.8 1.0 1.4 1.8 2.0];

polynomial_degree = 4;

hold on
find_approximational_polynomial(x, y, polynomial_degree);
find_polynomial_by_polyfit(x, y);
hold off

function find_polynomial_by_polyfit(x, y)
    polynomial_polyfit = polyfit(x, y, 2);
    plot(x, y);
    disp(['Polyfit coefitients: [' num2str(polynomial_polyfit(:).') ']']);
end

function find_approximational_polynomial(x, y, polynomial_degree)
    pow_x = pow_array(x, polynomial_degree);
    pow_y = pow_array(y, polynomial_degree);
    pow_xy = multiply_array_by_array(x, y, polynomial_degree);
    equation_system = create_matrix(pow_x, pow_y, pow_xy, length(x));
    determinant_array = solve_equation_by_cramers_rule(equation_system);
    disp(['Polynomial coefitients: [' num2str(determinant_array(:).') ']']);
    plot(x, polyval(determinant_array, x));
end

function p = pow_array(array, max_degree)
  p = [];
   for i = 1:1: max_degree
        p(i) = sum(array .^ (i));
    end
    disp(['The result pow is: [' num2str(p(:).') ']']);
end

function p = multiply_array_by_array(array_1, array_2, max_degree)
  p = []
   for i = 1:1: max_degree
        p(i) = sum(array_1 .^ (i) .* array_2);
    end
end

function matrix = create_matrix(pow_x, pow_y, pow_xy, N)
    matrix = [N         pow_x(1) pow_x(2) pow_y(1)
              pow_x(1)  pow_x(2) pow_x(3) pow_xy(1)
              pow_x(2)  pow_x(3) pow_x(4) pow_xy(2)];
    fprintf('The system of equations is:\n');
    fprintf('%.1fa + %.1fb + %.1f = %.1f\n', matrix.');
end

function determinant_array = solve_equation_by_cramers_rule(equation_system)
   % Ax = B
    A = equation_system(: , [1:3]);
    B = equation_system(: , 4);
    n = size(A)
    for i = 1:n(1)
        aux = A;
        aux(: , i) = B;
        determinant_array(i) = det(aux)/det(A);
    end
    determinant_array = fliplr(determinant_array);
end
