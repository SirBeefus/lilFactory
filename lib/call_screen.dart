import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'data/items.dart' ;
import 'data/world.dart';
import 'data/inventory.dart';
import 'data/metric.dart';
import 'data/recipe.dart';

class CallsScreen extends StatefulWidget{

  @override
  CallsScreenState createState() {
    return new CallsScreenState();
  }
}

World world = new World(cardObject: card, inventory: inv,);

Inventory inv = Inventory(item: <Item>[]);

List<CardObject> card = <CardObject>[
  Miner(item: <Item>[Iron(), Iron(), Copper()],),
  RoboticArm(workOnIcon: Icon(Icons.arrow_downward),  item: <Item>[]),
  Assembler(item: <Item>[]),
  RoboticArm(workOnIcon: Icon(Icons.arrow_downward), item: <Item>[]),
  Belt(direction: Direction(output: directionState.down), icon: Icon(Icons.arrow_downward),item: <Item>[]),

  Miner(item: <Item>[]),
  RoboticArm(workOnIcon: Icon(Icons.arrow_downward), item: <Item>[],),
  Assembler(recipe: BeltItemR(), workOnIcon: Icon(Icons.arrow_forward),item: <Item>[]),
  Belt(direction: Direction(output: directionState.left), icon: Icon(Icons.arrow_back),item: <Item>[]),
  Belt(direction: Direction(output: directionState.left), icon: Icon(Icons.arrow_back),item: <Item>[]),

  Belt(direction: Direction(output: directionState.left), icon: Icon(Icons.arrow_back),item: <Item>[]),
  Belt(direction: Direction(output: directionState.left), icon: Icon(Icons.arrow_back),item: <Item>[]),
  RoboticArm(direction: Direction(output: directionState.down), workOnIcon: Icon(Icons.arrow_downward),item: <Item>[]),
  Belt(item: <Item>[]),
  Box(item: <Item>[], mapItem: Map<Item, int>()),

  Box(item: <Item>[], mapItem: Map<Item, int>()),
  RoboticArm(workOnIcon: Icon(Icons.arrow_downward), item: <Item>[]),
  Box(item: <Item>[], mapItem: Map<Item, int>()),
  RoboticArm(workOnIcon: Icon(Icons.arrow_downward), item: <Item>[]),
  Belt(direction: Direction(output: directionState.down), icon: Icon(Icons.arrow_downward),item: <Item>[]),
];


class CallsScreenState extends State<CallsScreen> with SingleTickerProviderStateMixin{

  Animation<int> animation;
  AnimationController controller;

  int ind = 0;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );
    animation = IntTween(begin: 1, end: 2).animate(controller)
      ..addListener(() {
        setState(() {
        });
      })
      ..addStatusListener((status){
        if (status == AnimationStatus.completed) {
          _changeCellOnTick();
          if(ind == card.length) ind = 0;
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
    });
    controller.forward();
  }

  _changeCellOnTick(){
    setState(() {
      for(int i = 0; i < card.length; i++){
        if(card[i] is RoboticArm){
          world.itemTransitionArm(i);
        }
        if(card[i] is Belt){
          card[i].text = new Text(card[i].printItemCount(), style: new TextStyle(fontSize: 10.0),);
          world.itemTransitionBelt(i);
          //card[i].text = new Text(card[i].printItemCount(), style: new TextStyle(fontSize: 10.0),);
        }
        if(card[i] is Box){
          card[i].text = new Text(card[i].printItemCount(), style: new TextStyle(fontSize: 9.0),);
          world.itemAdd(Iron(), 0, 15);
        }
        if(card[i] is Assembler){
          card[i].text = new Text(card[i].printItemCount(), style: new TextStyle(fontSize: 9.0),);
          world.itemAssemble(i);
        }
        if(card[i] is Miner){
          card[i].text = new Text(card[i].printItemCount(), style: new TextStyle(fontSize: 9.0),);
          card[i].item.add(Iron());
          card[i].item.add(Copper());
        }
      }
    });
  }

  _changeCellOnTap(int index){
    if(card[index] is Belt){
      card[index].changeDirection();
    }
    if(card[index] is RoboticArm){
      card[index].changeDirection();
    }
    if(card[index] is Box){
      card[index].item.add(Iron());
      card[index].item.add(Copper());
    }
    if(card[index] is Assembler){
      card[index].changeRecipe();
    }
  }

  _changeCellDoubleOnTap(int index){
    card.removeAt(index);
  }

  _changeInventoryOnLongPress(int index){
    setState(() {
      world.itemToInventory(index);
    });
  }

  List<Widget> row(int index){
    List<Widget> r = <Widget>[];
    for(int i = 0; i < index; i++) {
      r.add(
        Stack(
          children:<Widget>[
            GestureDetector(
              child: DragTarget(
                onAccept: (context){
                  //card.insert(i ,Box(position: Position(posX: card.length), item: <Item>[]));
                  if(bBox==true){
                    if(world.inventory.item.contains(BoxItem())) {
                      card.insert(i, Box(position: Position(posX: card.length),
                          item: <Item>[]));
                      world.inventory.item.remove(BoxItem());
                    }
                  }
                  else if(bBelt==true){
                    if(world.inventory.item.contains(BeltItem())) {
                      card.insert(i, Belt(position: Position(posX: card.length),
                          item: <Item>[]));
                      world.inventory.item.remove(BeltItem());
                    }
                  }
                  else if(bRoboArm==true){
                    if(world.inventory.item.contains(RoboticArmItem())) {
                      card.insert(
                          i, RoboticArm(position: Position(posX: card.length), item: <Item>[]));
                      world.inventory.item.remove(RoboticArmItem());
                    }
                  }
                  else if(bAssembler==true){
                    if(world.inventory.item.contains(AssemblerItem())) {
                      card.insert(i, Assembler(
                          position: Position(posX: card.length),
                          item: <Item>[]));
                      world.inventory.item.remove(AssemblerItem());
                    }
                  }
                },
                  builder: (BuildContext context, List<dynamic> a, List<dynamic> b){
                    return Container(
                      margin: const EdgeInsets.all(7.0),
                      color: card[i].color,
                      width: a.isEmpty ? 70.0 : 50.0,
                      height: 70.0,
                      child: Column(
                        children: <Widget>[
                          new Row(
                              children: <Widget>[card[i].icon, card[i].workOnIcon]
                          ),
                          new Center(
                            child: card[i].text,
                          ),
                        ],
                      ),
                    );
                  }
              ),
              onTap: () => _changeCellOnTap(i),
              onDoubleTap: () => _changeCellDoubleOnTap(i),
              onLongPress: () => _changeInventoryOnLongPress(i),
            ),
          ]
        )
      );
    }
    return r;
  }

  bool bBelt = false;
  Widget buyBelt(){
    return Draggable(
      onDragStarted: ()=>bBelt = true,
      onDragEnd: (DraggableDetails d)=>bBelt = false,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(7.0),
          width: 20.0,
          height: 20.0,
          child: Icon(Icons.arrow_forward),
        ),
        onTap: ()=>{},
      ),
      feedback: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.grey.withOpacity(0.5),
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  bool bBox = false;
  Widget buyBox(){
    return Draggable(
      onDragStarted: ()=>bBox = true,
      onDragEnd: (DraggableDetails d)=>bBox = false,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(7.0),
          width: 20.0,
          height: 20.0,
          child: Icon(Icons.move_to_inbox),
        ),
        onTap: ()=>{},
      ),
      feedback: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.grey.withOpacity(0.5),
        child: Icon(Icons.move_to_inbox),
      ),
    );
  }
  bool bAssembler = false;
  Widget buyAssembler(){
    return Draggable(
      onDragStarted: ()=>bAssembler = true,
      onDragEnd: (DraggableDetails d)=>bAssembler = false,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(7.0),
          width: 20.0,
          height: 20.0,
          child: Icon(Icons.assessment),
        ),
        onTap: ()=>{},
      ),
      feedback: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.grey.withOpacity(0.5),
        child: Icon(Icons.assessment),
      ),
    );
  }

  bool bRoboArm = false;
  Widget buyRoboArm(){
    return Draggable(
      onDragStarted: ()=>bRoboArm = true,
      onDragEnd: (DraggableDetails d)=>bRoboArm = false,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(7.0),
          width: 20.0,
          height: 20.0,
          child: Icon(Icons.input),
        ),
        onTap: ()=>{},
      ),
      feedback: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.grey.withOpacity(0.5),
        child: Icon(Icons.input),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GridView.count(
            crossAxisCount: 5,
            children: row(card.length),
          ),
        ]
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: Colors.blueGrey,
          child: Column(
            children: <Widget>[
              Text(inv.printItemCount()),
              Row(
                children: <Widget>[
                  buyBelt(),
                  buyBox(),
                  buyRoboArm(),
                  buyAssembler(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

