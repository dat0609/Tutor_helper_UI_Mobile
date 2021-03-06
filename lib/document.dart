import 'package:flutter/material.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _top(),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "Manage your document",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("View All",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                ]),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 200.0,
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 3 / 2),
                children: <Widget>[
                  _gridItem(Icons.document_scanner, "Upload"),
                  _gridItem(Icons.create, "Create Quiz"),
                  _gridItem(Icons.note, "Note"),
                  _gridItem(Icons.location_on, "Location"),
                  _gridItem(Icons.map, "Map"),
                  _gridItem(Icons.contact_page, "Contact"),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const <Widget>[
                Text("Your uploaded",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ],
            ),
          ),
          _cardItem("https://www.computerhope.com/jargon/t/task.png"),
          _cardItem(
              "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"),
        ],
      ),
    );
  }

  _cardItem(String image) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.0))),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text("Hahaaaaaaaaaaaaaaaaaa",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              SizedBox(width: 10),
              Text("2 items",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              SizedBox(height: 10.0),
              Text("haha",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
            ],
          )
        ]));
  }

  _gridItem(icon, String msg) {
    return Column(children: <Widget>[
      CircleAvatar(
        child: Icon(
          icon,
          size: 16.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange.withOpacity(0.9),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        (msg),
        style: const TextStyle(
          fontSize: 11.0,
        ),
      )
    ]);
  }

  _top() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: Color(0xFFD4E7FE),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          )),
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: const <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Hi Jackie",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0XFF343E87)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
                IconButton(
                    icon: const Icon(Icons.notifications),
                    color: const Color(0xFFD4E7FE),
                    onPressed: () {})
              ]),
          const SizedBox(height: 30.0),
          TextField(
              decoration: InputDecoration(
            hintText: "Search",
            fillColor: Colors.white,
            filled: true,
            suffixIcon: const Icon(Icons.filter_list),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.grey)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          ))
        ],
      ),
    );
  }
}
