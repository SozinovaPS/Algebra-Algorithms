pkg load symbolic
function factorization %main
  clear;
  clc;
  n = input('Ведите n = ');
  N = input('Введите N = ');
  primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127];
  ans = Pollard(n, N, primes)
end

function ans = Pollard(n, B, list)
  M = 1;
  for i = 1:length(list)
    p = list(i);
    if p > B
      break
    endif
    M = M * p^floor(log(B)/log(p));
  endfor
  aM = mod(sym(2)^M, n);
  g = find_gcd(aM-1, n);
  ans = sym(1);
  k1 = n - g;
  k2 = g - 1;
  if k1 > 0 && k2 > 0
    ans = g;
  endif
end

function x = find_gcd(a, b)
  while a != b
    if a > b
        a = a - b;
    else
        b = b - a;
    end
  end
    x = a;
end
