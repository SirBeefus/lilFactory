import 'package:flutter/material.dart';

import 'world.dart';
import 'recipe.dart';
import 'metric.dart';

class CardObject extends World{
  CardObject({
    this.position,
    this.direction = const Direction(output: directionState.right),
    this.size,
    ///Material
    this.color,
    this.icon,
    this.workOnIcon,
    this.text,
    ///
    this.recipe,
    this.item,
    this.mapItem
  });

  Position position;
  Direction direction;
  ///Material
  Size size;
  Color color;
  Icon icon;
  Icon workOnIcon;
  ///
  Recipe recipe;
  Text text;
  List<Item> item = <Item>[];
  List<Item> itemInput = <Item>[];
  List<Item> itemOutput = <Item>[];
  Map<Item, int> mapItem;

  String printItemCount(){
    List<Item> all = item + itemInput + itemOutput;
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
    return map.isNotEmpty ? map.toString() : '';
  }

  changeDirection() {
    switch (this.runtimeType) {
      case Belt:
        if (direction == Direction(output: directionState.right)) {
          direction = Direction(output: directionState.down);
          icon = Icon(Icons.arrow_downward);
        }
        else if (direction == const Direction(output: directionState.down)) {
          direction = const Direction(output: directionState.left);
          icon = Icon(Icons.arrow_back);
        }
        else if (direction == const Direction(output: directionState.left)) {
          direction = Direction(output: directionState.up);
          icon = Icon(Icons.arrow_upward);
        }
        else if (direction == const Direction(output: directionState.up)) {
          direction = Direction(output: directionState.right);
          icon = Icon(Icons.arrow_forward);
        }
        break;
      case RoboticArm:
        if (direction == Direction(output: directionState.right)) {
          direction = Direction(output: directionState.down);
          workOnIcon = Icon(Icons.arrow_downward);
        }
        else if (direction == const Direction(output: directionState.down)) {
          direction = const Direction(output: directionState.left);
          workOnIcon = Icon(Icons.arrow_back);
        }
        else if (direction == const Direction(output: directionState.left)) {
          direction = Direction(output: directionState.up);
          workOnIcon = Icon(Icons.arrow_upward);
        }
        else if (direction == const Direction(output: directionState.up)) {
          direction = Direction(output: directionState.right);
          workOnIcon = Icon(Icons.arrow_forward);
        }
        break;
    }
  }

  changeRecipe(){
    switch(recipe.runtimeType){
      case IronGearR:
        recipe = CircuitR();
        workOnIcon = Icon(Icons.blur_on);
        break;
      case CircuitR:
        recipe = BeltItemR();
        workOnIcon = Icon(Icons.arrow_forward);
        break;
      case BeltItemR:
        recipe = RoboticArmItemR();
        workOnIcon = Icon(Icons.input);
        break;
      case RoboticArmItemR:
        recipe = IronGearR();
        workOnIcon = Icon(Icons.brightness_low);
        break;
    }
  }

  addItemToMap(Item item){
    if(!mapItem.containsKey(item)){
      mapItem[item]=1;
    }else if(mapItem.containsKey(item)){
      mapItem[item]++;
    }

  }

  Color toColor(){
    return Colors.black;
  }

}

class Box extends CardObject{
  Box({
    this.position,
    this.size,
    ///Material
    this.color = Colors.grey,
    this.text = const Text('Box'),
    this.icon = const Icon(Icons.move_to_inbox),
    this.workOnIcon = const Icon(Icons.insert_link),
    ///
    this.item,
    this.mapItem
  }) :
        super(
          position:position,
          size:size,
          //Material
          color:color,
          text:text,
          icon:icon,
          //
          item:item,
          mapItem:mapItem
      );

  Position position;
  Size size;
  ///Material
  Color color;
  Text text;
  Icon icon;
  Icon workOnIcon;
  ///
  List<Item> item = <Item>[];
  Map<Item, int> mapItem = {};

  Color toColor(){
    return Colors.grey;
  }

}

class RoboticArm extends CardObject{
  RoboticArm({
    this.position,
    this.direction = const Direction(output: directionState.right),
    this.size,
    ///Material
    this.color = Colors.yellow,
    this.text = const Text('RoboticArm'),
    this.icon = const Icon(Icons.input),
    this.workOnIcon = const Icon(Icons.insert_link),
    ///
    this.item,
    this.mapItem
  }) :
        super(
          position:position,
          direction:direction,
          size:size,
          ///Material
          color:color,
          text:text,
          icon:icon,
          ///
          item:item,
          mapItem:mapItem
      );

  Position position;
  Direction direction;
  Size size;
  ///Material
  Color color;
  Text text;
  Icon icon;
  Icon workOnIcon;
  ///
  List<Item> item = <Item>[];
  Map<Item, int> mapItem = {};

  @override
  String toString() {
    return "RoboticArm";
  }
  Color toColor(){
    return Colors.yellow;
  }

}

class Belt extends CardObject{
  Belt({
    this.position,
    this.direction = const Direction(output: directionState.right),
    this.size,
    ///Material
    this.color = Colors.blue,
    this.text = const Text('Belt'),
    this.icon = const Icon(Icons.arrow_forward,),
    this.workOnIcon = const Icon(Icons.insert_link),
    ///
    this.item,
    this.mapItem
  }) :
        super(
          position:position,
          direction:direction,
          size:size,
          ///Material
          color:color,
          text:text,
          icon:icon,
          ///
          item:item,
          mapItem:mapItem,
      );

  Position position;
  Direction direction;
  Size size;
  ///Material
  Color color;
  Text text;
  Icon icon;
  Icon workOnIcon;
  ///
  List<Item> item = <Item>[];
  Map<Item, int> mapItem = {};

  Color toColor(){
    return Colors.blue;
  }
}

class Assembler extends CardObject{
  Assembler({
    this.position,
    this.direction = const Direction(output: directionState.right),
    this.size,
    ///Material
    this.color = Colors.green,
    this.text = const Text('Assembler'),
    this.icon = const Icon(Icons.assessment,),
    this.workOnIcon = const Icon(Icons.brightness_low),
    ///
    this.recipe = const IronGearR(),
    this.item,
    this.mapItem
  }) :
        super(
          position:position,
          direction:direction,
          size:size,
          ///Material
          color:color,
          text:text,
          icon:icon,
          workOnIcon:workOnIcon,
          ///
          recipe:recipe,
          item:item,
          mapItem:mapItem
      );

  Position position;
  Direction direction;
  Size size;
  ///Material
  Color color;
  Text text;
  Icon icon;
  Icon workOnIcon;
  ///
  Recipe recipe;
  List<Item> item = <Item>[];
  Map<Item, int> mapItem = {};
  List<Item> itemInput = <Item>[];
  List<Item> itemOutput = <Item>[];

  Color toColor(){
    return Colors.green;
  }
}

class Miner extends CardObject{
  Miner({
    this.position,
    this.size,
    ///Material
    this.color = Colors.brown,
    this.text = const Text('Miner'),
    this.icon = const Icon(Icons.apps),
    this.workOnIcon = const Icon(Icons.wb_iridescent),
    ///
    this.item
  }) :
        super(
          position:position,
          size:size,
          //Material
          color:color,
          text:text,
          icon:icon,
          workOnIcon:workOnIcon,
          //
          item:item);

  Position position;
  Size size;
  ///Material
  Color color;
  Text text;
  Icon icon;
  Icon workOnIcon;
  ///
  List<Item> item = <Item>[];

  Color toColor(){
    return Colors.grey;
  }
}



class Item{
  const Item({
    this.icon
  });

  final Icon icon;

  bool operator ==(i) => i is Item;
}

class Iron extends Item{
  const Iron({
    this.icon = const Icon(Icons.wb_iridescent)
  });

  final Icon icon;

  String toString()=>'Iron';
}

class Copper extends Item{
  const Copper({
    this.icon
  });

  final Icon icon;

  String toString()=>'Copper';
}

class IronPlate extends Item{
  const IronPlate({
    this.icon = const Icon(Icons.wb_iridescent)
  });

  final Icon icon;

  String toString()=>'IronPlate';
}

class CopperPlate extends Item{
  const CopperPlate({
    this.icon
  });

  final Icon icon;

  String toString()=>'CopperPlate';
}

class Steel extends Item{
  const Steel({
    this.icon
  });

  final Icon icon;

  String toString()=>'Steel';
}

class IronGear extends Item{
  const IronGear({
    this.icon = const Icon(Icons.brightness_low)
  });

  final Icon icon;

  String toString()=>'IronGear';
}

class Circuit extends Item{
  const Circuit({
    this.icon = const Icon(Icons.blur_on),
  });

  final Icon icon;

  String toString()=>'Circuit';
}

class BeltItem extends Item{
  const BeltItem({
    this.icon = const Icon(Icons.arrow_forward),
  });

  final Icon icon;

  String toString()=>'Belt';
}

class RoboticArmItem extends Item{
  const RoboticArmItem({
    this.icon = const Icon(Icons.input),
  });

  final Icon icon;

  String toString()=>'RoboticArm';
}

class BoxItem extends Item{
  const BoxItem({
    this.icon = const Icon(Icons.input),
  });

  final Icon icon;

  String toString()=>'Box';
}

class AssemblerItem extends Item{
  const AssemblerItem({
    this.icon = const Icon(Icons.input),
  });

  final Icon icon;

  String toString()=>'Assembler';
}
