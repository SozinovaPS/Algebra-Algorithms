pkg load symbolic

function Lucas_test %main

    primes =  [ 2,	 3,	 5,   7,	11,	13,	 17,	19,  23,	29,	...
                 31, 37, 41, 43,	47,	53,	 59,	61,	 67,	71, ...
                 73, 79, 83, 89,	97,	101, 103, 107, 109, 113, 127 ];

    min = 3;
    max = 8;

    [n, divisors] = generate_n(primes, min, max);

    different_divisors = 5;
    while length(divisors) < different_divisors
        [n, divisors] = generate_n(primes, min, max);
    endwhile

    disp('Generated n:')
    disp(n)
    disp('Divisors of (n-1):')
    disp(divisors')

     % Cecking if n is prime
    [flag,a] = test(n, divisors, min);

    if flag
        disp('n is prime')
        a
    else
        disp('n is NOT prime')
    endif

end;

function [n,divisors] = generate_n(primes,deg_down,deg_up)

    % Generating n: 2^deg_down < n < 2^deg_up
    % from given list of primes

    l = length(primes);

    n = sym(2);
    bord_down = sym(2)^deg_down;
    bord_up = sym(2)^deg_up;
    multipliers = zeros(1,l);
    multipliers(1) = 1;

    while n < bord_down
      multr_i = randi(l);
      n *= primes(multr_i);
      multipliers(multr_i) += 1;
    endwhile

    while n > bord_up
        n /= primes(multr_i);
        multipliers(multr_i) -= 1;
        multr_i -= 1;
        n *= primes(multr_i);
        multipliers(multr_i) += 1;
    endwhile

    n += 1;

    % Now we have n

    % Creating list of different prime divisors of (n-1)
    divisors = 2;
    for k = 2 : l
        if multipliers(k)
            divisors = [ divisors, primes(k) ];
        endif
    endfor

endfunction


function [flag,a] = test(n, divisors, deg_down)

    % Defining log2(n):
    a_max = sym(2)^deg_down;
    while a_max < n
      a_max *= 2;
    endwhile
    a_max = log2(a_max)

    % Checking if n is prime

    flag = 0;
    a = 1;

    disp('Algorithm in process...')

    while !flag && a < a_max
        a += 1;
        disp('checking a=')
        disp(a)
        test1 = mod(sym(a)^n-1,n);

        if test1 == 1

            divs = length(divisors);
            test2 = 0;
            k = 1;
            while ( test2 ~= 1 ) && ( k < divs+1 )
                deg = (n-1)/divisors(k);
                test2 = mod(sym(a)^deg, n);
                k = k+1;
            endwhile

            if k == divs+1
                flag = 1;
            endif

        endif
    endwhile

endfunction
