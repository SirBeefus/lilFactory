enum directionState {up, down, left, right}

class Direction{
  const Direction({this.output});

  final directionState output;

  bool operator ==(d) => d is Direction && d.output == output;

  @override
  String toString(){
    return output.toString();
  }
}

class Position{
  Position({this.posX, this.posY});

  int posX, posY;

}

class Size{

}