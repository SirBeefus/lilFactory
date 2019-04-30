import 'items.dart';
import 'inventory.dart';
import 'recipe.dart';
import 'metric.dart';

class World {
  World({this.cardObject, this.inventory});

  List<CardObject> cardObject = <CardObject>[];
  Inventory inventory;

  final int rowSize = 5;

  void _inputBelt(int inPutItem, int outPutItem){
    if (cardObject[inPutItem].item.length < 6) {
      ///Add and Remove item
      cardObject[inPutItem]
          .item
          .add(cardObject[outPutItem].item[0]);
      cardObject[outPutItem].item.removeAt(0);
    }
  }

  void _inputDefault(int inPutItem, int outPutItem){
    cardObject[inPutItem]
        .item
        .add(cardObject[outPutItem].item[0]);
    cardObject[outPutItem].item.removeAt(0);
  }

  void _inputBeltFromAssembler(int inPutItem, int outPutItem){
    if (cardObject[inPutItem].item.length < 6) {
      ///Add and Remove item
      cardObject[inPutItem]
          .item
          .add(cardObject[outPutItem].itemOutput[0]);
      cardObject[outPutItem].itemOutput.removeAt(0);
    }
  }

  void _inputDefaultFromAssembler(int inPutItem, int outPutItem){
    cardObject[inPutItem]
        .item
        .add(cardObject[outPutItem].itemOutput[0]);
    cardObject[outPutItem].itemOutput.removeAt(0);
  }

  void _inputAssembler(int inPutItem, int outPutItem){


    for(int i = 0; i < cardObject[inPutItem].recipe.ingredients.length; i++){
      for (int j = 0; j < cardObject[outPutItem].item.length; j++) {
        if (cardObject[inPutItem].recipe.ingredients[i].runtimeType == cardObject[outPutItem].item[j].runtimeType) {
          cardObject[inPutItem].item.add(
              cardObject[outPutItem].item[j]
          );
          cardObject[outPutItem].item.removeAt(j);
        }
      }
    }
  }

  itemTransitionArm(int index) {

    int outPutItem;
    int inPutItem;

    ///structure of this function:
    ///switch object
    ///switch direction
    ///check if adjacent objects exist
    ///switch output object
    ///switch input object

    switch (cardObject[index].direction.output) {

      ///Card direction
      case directionState.right:

        ///Item put from left to right
        outPutItem = index - 1;
        inPutItem = index + 1;
        if ((index < cardObject.length - 1 && index >= 1)) {

          ///Items taken from:
          ///Check if next Card isn't in new Line
          if ((inPutItem) % rowSize != 0) {
            switch (cardObject[outPutItem].runtimeType) {
              case Assembler:

                ///Items given from Assembler to...
                if (cardObject[outPutItem].itemOutput.isNotEmpty) {
                  switch (cardObject[inPutItem].runtimeType) {

                    ///...Belt
                    case Belt:
                      _inputBeltFromAssembler(inPutItem, outPutItem);
                      break;

                    ///...non specific CardObject
                    default:
                      _inputDefaultFromAssembler(inPutItem, outPutItem);
                      break;
                  }
                }
                break;

              /// ...RoboticArm
              case RoboticArm:

                ///no items can be placed in RoboticArm
                break;
              default:
                if (cardObject[outPutItem].item.isNotEmpty) {
                  ///Items given from non specific Card to...
                  switch (cardObject[inPutItem].runtimeType) {

                    ///...Belt.
                    case Belt:
                      _inputBelt(inPutItem, outPutItem);
                      break;

                    ///Assembler
                    case Assembler:
                        _inputAssembler(inPutItem, outPutItem);
                      break;

                    ///...non specific Card.
                    default:
                      _inputDefault(inPutItem, outPutItem);
                      break;
                  }
                }
                break;
            }
          }
        }
        break;
      case directionState.left:

      ///Item put from right to left
        outPutItem = index + 1;
        inPutItem = index - 1;
        if ((index < cardObject.length - 1 && index >= 1)) {
          ///Items taken from:
          ///Check if next Card isn't in new Line
          if ((inPutItem) % rowSize != 0) {
            switch (cardObject[outPutItem].runtimeType) {
              case Assembler:

              ///Items given from Assembler to...
                if (cardObject[outPutItem].itemOutput.isNotEmpty) {
                  switch (cardObject[inPutItem].runtimeType) {

                  ///...Belt
                    case Belt:
                      _inputBeltFromAssembler(inPutItem, outPutItem);
                      break;

                  ///...non specific CardObject
                    default:
                      _inputDefaultFromAssembler(inPutItem, outPutItem);
                      break;
                  }
                }
                break;

            /// ...RoboticArm
              case RoboticArm:

              ///no items can be placed in RoboticArm
                break;
              default:
                if (cardObject[outPutItem].item.isNotEmpty) {
                  ///Items given from non specific Card to...
                  switch (cardObject[inPutItem].runtimeType) {

                  ///...Belt.
                    case Belt:
                      _inputBelt(inPutItem, outPutItem);
                      break;

                  ///Assembler
                    case Assembler:
                      _inputAssembler(inPutItem, outPutItem);
                      break;

                  ///...non specific Card.
                    default:
                      _inputDefault(inPutItem, outPutItem);
                      break;
                  }
                }
                break;
            }
          }
        }
        break;
      case directionState.up:

      ///Item put from down to up
        outPutItem = index + rowSize;
        inPutItem = index - rowSize;
        if ((outPutItem < cardObject.length && index >= 5)) {
          ///Items taken from:
          ///Check if next Card isn't in new Line
            switch (cardObject[outPutItem].runtimeType) {
              case Assembler:

              ///Items given from Assembler to...
                if (cardObject[outPutItem].itemOutput.isNotEmpty) {
                  switch (cardObject[inPutItem].runtimeType) {

                  ///...Belt
                    case Belt:
                      _inputBeltFromAssembler(inPutItem, outPutItem);
                      break;

                  ///...non specific CardObject
                    default:
                      _inputDefaultFromAssembler(inPutItem, outPutItem);
                      break;
                  }
                }
                break;

            /// ...RoboticArm
              case RoboticArm:

              ///no items can be placed in RoboticArm
                break;
              default:
                if (cardObject[outPutItem].item.isNotEmpty) {
                  ///Items given from non specific Card to...
                  switch (cardObject[inPutItem].runtimeType) {

                  ///...Belt.
                    case Belt:
                      _inputBelt(inPutItem, outPutItem);
                      break;

                  ///Assembler
                    case Assembler:
                      _inputAssembler(inPutItem, outPutItem);
                      break;

                  ///...non specific Card.
                    default:
                      _inputDefault(inPutItem, outPutItem);
                      break;
                  }
                }
                break;
            }
        }
        break;
      case directionState.down:

      ///Item put from up to down
        outPutItem = index - rowSize;
        inPutItem = index + rowSize;
        if ((outPutItem < cardObject.length && index >= 5)) {
          ///Items taken from:
          ///Check if next Card isn't in new Line
          switch (cardObject[outPutItem].runtimeType) {
            case Assembler:

            ///Items given from Assembler to...
              if (cardObject[outPutItem].itemOutput.isNotEmpty) {
                switch (cardObject[inPutItem].runtimeType) {

                ///...Belt
                  case Belt:
                    _inputBeltFromAssembler(inPutItem, outPutItem);
                    break;

                ///...non specific CardObject
                  default:
                    _inputDefaultFromAssembler(inPutItem, outPutItem);
                    break;
                }
              }
              break;

          /// ...RoboticArm
            case RoboticArm:

            ///no items can be placed in RoboticArm
              break;
            default:
              if (cardObject[outPutItem].item.isNotEmpty) {
                ///Items given from non specific Card to...
                switch (cardObject[inPutItem].runtimeType) {

                ///...Belt.
                  case Belt:
                    _inputBelt(inPutItem, outPutItem);
                    break;

                ///Assembler
                  case Assembler:
                    _inputAssembler(inPutItem, outPutItem);
                    break;

                ///...non specific Card.
                  default:
                    _inputDefault(inPutItem, outPutItem);
                    break;
                }
              }
              break;
          }
        }
        break;
      default:
        break;
    }
  }

  itemTransitionBelt(int index) {
    if (cardObject[index].direction ==
        Direction(output: directionState.right)) {
      for (Item i in cardObject[index].item) {
        if (index + 1 < cardObject.length) {
          if((index + 1)% 5 != 0) {
            cardObject[index + 1].item.add(i);
          }
        }
      }
      if (index + 1 < cardObject.length) {
        if((index + 1)% 5 != 0) {
          cardObject[index].item.clear();
        }
      }
    } else if (cardObject[index].direction ==
        Direction(output: directionState.down)) {
      for (Item i in cardObject[index].item) {
        if (index + 5 < cardObject.length) {
          cardObject[index + 5].item.add(i);
        }
      }
      if (index + 5 < cardObject.length) {
        cardObject[index].item.clear();
      }
    } else if (cardObject[index].direction ==
        Direction(output: directionState.up)) {
      for (Item i in cardObject[index].item) {
        if (index - 5 > 0) {
          cardObject[index - 5].item.add(i);
        }
      }
      if (index - 5 > 0) {
        cardObject[index].item.clear();
      }
    } else if (cardObject[index].direction ==
        Direction(output: directionState.left)) {
      for (Item i in cardObject[index].item) {
        if (index - 1 > 0) {
          cardObject[index - 1].item.add(i);
        }
      }
      if (index - 1 > 0) {
        cardObject[index].item.clear();
      }
    }
  }

  void _itemRemove(int index){
    cardObject[index].recipe.ingredients.forEach(
            (i)=>cardObject[index].item.remove(i)
    );
  }

  bool _itemCheck(int index) {
    List<Item> all = cardObject[index].item;
    List<String> allS = new List<String>();
    for(Item i in all){
      allS.add(i.toString());
    }
    Map<String, int> map = new Map<String, int>();
    for(String s in allS){
      map.putIfAbsent(s, ()=> 0);
      if(map.containsKey(s)){
        map[s] = map[s] + 1;
      }
    }

    return false;
  }


  itemAssemble(int index) {
    //_itemCheck(index);
    switch(cardObject[index].recipe.runtimeType){
      case IronGearR:
        if(cardObject[index].recipe.ingredients.length <= cardObject[index].item.length){
          _itemRemove(index);
          cardObject[index].itemOutput.add(IronGear());
        }
        break;
      case CircuitR:
        if(cardObject[index].recipe.ingredients.length <= cardObject[index].item.length){
          _itemRemove(index);
          cardObject[index].itemOutput.add(Circuit());
        }
        break;
      case BeltItemR:
        if(cardObject[index].recipe.ingredients.length <= cardObject[index].item.length){
          _itemRemove(index);
          cardObject[index].itemOutput.add(BeltItem());
        }
        break;
      case RoboticArmItemR:
        if(cardObject[index].recipe.ingredients.length <= cardObject[index].item.length){
          _itemRemove(index);
          cardObject[index].itemOutput.add(RoboticArmItem());
        }
        break;
    }
  }

  itemToInventory(int index) {
    for (Item i in cardObject[index].item) {
      inventory.item.add(i);
    }
    cardObject[index].item.clear();
  }

  ///Item transition via maps
  itemAdd(Item item, int itemNumber, int inputObject){
    cardObject[inputObject].addItemToMap(item);
    print(cardObject[inputObject].mapItem);
  }
}
