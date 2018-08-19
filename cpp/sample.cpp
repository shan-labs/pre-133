#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <limits>

using namespace std;

int getinput(int lim){
  int i;
  //in case user input was wrong
  if ( !(cin >> i) or i < 0 or i > lim) {
    //reset cin here
    cin.clear();
    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    printf("Woah there, that isn't a valid input..\n For time's sake, you'll be assigned a number.\n");
    //initialize random seed
    srand (time(NULL));
    //generate number between 1 and lim - 1 
    i = rand() % (lim - 1) + 1;
  }
  printf("Number = %d\n", i); //inform user
  return i;
}

void factorial(int i){
  //base case
  unsigned int value = 1;
  //in case it's not base case
  if( i > 1){
    //loop to base case
    for(; i >= 2; i--){
      value *= i;
    }
  }
  printf("The factorial is %u!\n\n", value);
}

void fibonacci(int i){
  unsigned int value;
  //base cases.. sorta
  if(i < 2){
    value = i;
  }else{
    unsigned int a = 0, b = 1, c; //a more "iterative solution"
    for(int j = 2; j <= i; j++){
      c = a + b;
      a = b;
      b = c;
    }
    value = b;
  }
  printf("The fibonacci number at index %d is %u!\n", i, value);
}

int main(){
  //self imposed limits (due to memory of issues/ speed)
  int lim;
  
  //user input integer
  int input;

  //explain
  printf("Hello! First, type a number and we'll determine the its factorial. Let it be less than or equal to 12, for the sake of memory.\n Input: ");
  
  input = getinput(12); //ask for input + validate input
  factorial(input); //calculate
  
  //explain next
  printf("Now, type a number and we'll find the nth number in the fibonacci sequence (index starting at 0) at that index. Let it be less than or equal to 47, for the sake of memory.\n Input: ");
  
  input = getinput(47); //ask for input + validate input
  fibonacci(input); //calculate
  
  //finished
  printf("\nFin\n");
  return 0;
}
