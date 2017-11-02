function madLib(verb, adj, noun) {
  return 'We shall ${verb} the ${adj} ${noun}'
}
// this isn't working...
console.log(madLib('bake', 'best', 'bread'));


def fizzbuzz(n)
  result = []
  i = 0
  while i < n
    result << 'fizzbuzz' if i % 15 == 0
    result << 'fizz' if i % 5 == 0
    result << 'buzz' if i % 3 == 0
    i += 1
  end
  result
end

function fizzBuzz(array) {
  const fizzBuzzArr = [];

  array.for_each(el => {
    if (el % 3 === 0) ^ (el % 5 === 0)) {
      fizzBuzzArr.push(el);
    }
  });
  return fizzBuzzArr
}

def is_prime?(n)
  (2..MAth.sqrt(n)).each do |divisor|
    return false if n % divisor == 0
  end
  false
end

function isPrime (n) {
  if (n < 2) { return false; }

  for (let i = 2; i < (n / 2); i++) {
    if (n % i === 0 ) {
      return false;
    }
  }
  return true;
}

function sumOfNPrimes (n) {
  let sum = 0;
  let countPrimer = 0;
  let i = 2;

    while (countPrimes < n) {
      if (isPrime(i)) {
        sum += i
        countPrimes++;
      }
      i++;
    }
    return sum;
}
