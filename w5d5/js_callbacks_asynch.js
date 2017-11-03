// First, set a simple timeout for 5000 ms (use window.setTimeout).
// Pass in a callback function that calls alert('HAMMERTIME')
// asynchronous call; still able to interact with website in browser
// before the alert is rendered

window.setTimeout(function (){
  console.log(alert('HAMMERTIME!'));
}, 5000);

// same function as above, but this accepts an argument/ callback

function whatTimeIsHammerTime(time) {
  window.setTimeout(function (){
    console.log(alert(`${time} is HAMMERTIME!`));
  }, 5000);
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// asks user if they'd like tea and biscuits; it will:
// ask the user if they'd like tea, display their response, ask if they'd
// like biscuits, display their complete response using interpolation,
// then close the reader.

// these lines require the readline library to get standard input/output
const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// // defines the function; first issue was that I was closing off the brackets
// // between each question and the response, but then the console.log
// // method doesn't have access to the response vars; needed to make sure
// // they were all within the same scope so the response dialogue had
// // access to the question/ response vars.
function teaAndBiscuits () {

  reader.question('Would you like some tea?', function (res) {
    console.log(`You replied ${res}.`);

    reader.question('Would you like some buscuits?', function (res2) {
      console.log(`You replied ${res2}.`);

      const firstRes = (res === 'yes') ? 'do' : 'don\'t';
      const secondRes = (res2 === 'yes') ? 'do' : 'don\'t';

      console.log(
        `So...let me get this straight...you ${firstRes} want tea,
        and you ${secondRes} want biscuits? Okay...`
      );
        reader.close();
    });
  });
}
// // remember to invoke the funciton you're outputting by adding the closed
// // parenthesis after the call (teaAndBiscuits())
console.log(teaAndBiscuits());

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// practice calling methods in different ways

function Cat () {
  this.name = 'Markov';
  this.age = 3;
}

function Dog () {
  this.name = 'Noodles';
  this.age = 4;
}

Dog.prototype.chase = function (cat) {
  console.log(`My name is ${this.name} and I'm chasing ${cat.name}! Woof!`)
};

const Markov = new Cat ();
const Noodles = new Dog ();

// method-style call
console.log(Noodles.chase(Markov));

// calling method with 'call'
console.log(Noodles.chase.call(Markov, Noodles));

// calling method with 'apply'
console.log(Noodles.chase.apply(Noodles, [Markov]));

// The below didn't work because one arg needs to be in an array
// console.log(Noodles.chase.apply([Noodles, Markov]))
