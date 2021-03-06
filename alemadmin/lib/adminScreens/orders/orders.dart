import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance
    .collection('orders')
    .orderBy('id', descending: true)
    .snapshots();

class Orders extends StatefulWidget {
  static const String id = 'orders';
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
          title: Text('Заказы'),
        ),
        body: StreamBuilder(
            stream: _firestore,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot orders = snapshot.data.docs[index];
                    final alemId = orders.data()['alemid'];
                    final name = orders.data()['name'];
                    final totalQuantity = orders.data()['quantity'];
                    final quantity = orders.data()['quantities'];
                    final sizes = orders.data()['size'];
                    final myDateTime = orders.data()['date'];
                    final user = orders.data()['user'];
                    final colors = orders.data()['color'];
                    final price = orders.data()['price'];
                    final photo = orders.data()['imgUrl'];
                    final inProcess = orders.data()['inProcess'];
                    final completed = orders.data()['completed'];
                    final documentId = orders.data()['documentId'];
                    final id = orders.data()['id'];

                    return OrderCard(
                        alemId: alemId,
                        name: name,
                        totalQuantity: totalQuantity,
                        quantity: quantity,
                        sizes: sizes,
                        myDateTime: myDateTime,
                        user: user,
                        colors: colors,
                        price: price,
                        photo: photo,
                        inProcess: inProcess,
                        completed: completed,
                        id: id,
                        documentId: documentId);
                  });
            }));
  }
}

class OrderCard extends StatefulWidget {
  final String alemId;
  final String name;
  final int totalQuantity;
  final List quantity;
  final List sizes;
  final String myDateTime;
  final String user;
  final List colors;
  final double price;
  final String photo;
  final bool inProcess;
  final bool completed;
  final String documentId;
  final int id;
  OrderCard(
      {Key key,
      this.alemId,
      this.name,
      this.totalQuantity,
      this.quantity,
      this.sizes,
      this.myDateTime,
      this.user,
      this.colors,
      this.price,
      this.photo,
      this.inProcess,
      this.completed,
      this.documentId,
      this.id})
      : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isInProcess;
  bool isCompleted;

  @override
  void initState() {
    super.initState();
    isInProcess = widget.inProcess;
    isCompleted = widget.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: (isInProcess && isCompleted) ? Colors.greenAccent : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Имя:", style: TextStyle(fontSize: 18)),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("${widget.name}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              Text("AlemId: ${widget.alemId}", style: TextStyle(fontSize: 16)),
              Text("Общая количество: ${widget.totalQuantity}",
                  style: TextStyle(fontSize: 16)),
              Text("Количество: ${widget.quantity}",
                  style: TextStyle(fontSize: 16)),
              widget.colors != null
                  ? Text("Цвет: ${widget.colors}",
                      style: TextStyle(fontSize: 16))
                  : Text('Цвет не выбран '),
              Text("Размер: ${widget.sizes}", style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Text("Цена: ", style: TextStyle(fontSize: 16)),
                  Text(
                    '${widget.price}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]),
                  ),
                ],
              ),
              SizedBox(
                child: Divider(color: Colors.amber.shade100),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.id != null
                        ? Text(
                            'Номер заказа: ${widget.id}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text(''),
                    SizedBox(
                      height: 5.0,
                    ),
                    widget.myDateTime != null
                        ? Text('${widget.myDateTime}')
                        : Text(''),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('${widget.user}', style: TextStyle(fontSize: 16)),
                    (isInProcess && isCompleted)
                        ? Container(
                            padding: EdgeInsets.all(5.0),
                            color: Colors.green,
                            child: Text('Завершено'),
                          )
                        : Container(
                            padding: EdgeInsets.all(5.0),
                            color: Colors.amber,
                            child: Text('Готовиться'),
                          ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: isInProcess,
                          onChanged: (bool value) {
                            setState(() {
                              isInProcess = !isInProcess;

                              updateInProcess(isInProcess);
                            });
                          },
                        ),
                        Text('Готовиться'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: isCompleted,
                          onChanged: (bool value) {
                            setState(() {
                              isCompleted = !isCompleted;

                              updateCompleted(isCompleted);
                            });
                          },
                        ),
                        Text('Завершено'),
                      ],
                    ),
                  ],
                ),
                Container(
                    height: MediaQuery.of(context).size.width * 0.25,
                    width: MediaQuery.of(context).size.width * 0.25,
                    color: Colors.black26,
                    child: (widget.photo != null)
                        ? Image.network(widget.photo)
                        : Center(child: Text('No photo')))
              ]),
            ],
          ),
        ),
      ),
    );
  }

  updateInProcess(isInProcess) async {
    var update = await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.documentId)
        .update({'inProcess': isInProcess});
    return update;
  }

  updateCompleted(isCompleted) async {
    var update = await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.documentId)
        .update({'completed': isCompleted});
    return update;
  }
}
