

// server Exception
class backendError implements Exception{

  String errorMessage() {
    return "error in server";
  }
}



// Too much Movies Exception
class TooMuch implements Exception{

  String errorMessage() {
    return "TOO much movies please Enter more than 3 characters";
  }
}

// invalid name Exception
class InvalidName implements Exception{

  String errorMessage() {
    return "Enter a valid Movie Name please!";
  }
}




void backenderror (int num){
  if(num==500 || num==503) {

    throw backendError();


  }
}


void toomuch (String str){
  if(str=="Too many results.")
  print("TOO much movies , please Enter more than 3 characters");
  throw TooMuch();

}


void invalidName (String str){
  if(str=="Movie not found!")
  print("Enter a valid Movie Name please!");
  throw TooMuch();
}