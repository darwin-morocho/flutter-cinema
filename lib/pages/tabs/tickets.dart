import 'package:flutter/material.dart';
import 'package:topcinema/constants.dart';
import 'package:topcinema/utils/extras.dart';

class TicketsTab extends StatefulWidget {
  @override
  _TicketsTabState createState() => _TicketsTabState();
}

class _TicketsTabState extends State<TicketsTab> {
  final _tickes = List<Ticket>();

  @override
  void initState() {
    super.initState();
    _tickes.add(Ticket(
        dateTime: DateTime.parse("2019-08-05 11:00"),
        movieName: "Avengers End Game",
        room: 3,
        seatNumber: "A45"));

    _tickes.add(Ticket(
        dateTime: DateTime.parse("2019-09-13 15:00"),
        movieName: "IT 2",
        room: 1,
        seatNumber: "D45"));
    _tickes.add(Ticket(
        dateTime: DateTime.parse("2019-09-23 10:00"),
        movieName: "Toy Story 4",
        room: 2,
        seatNumber: "f5"));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          width: double.infinity,
          child: Column(
            children: _tickes.map((Ticket ticket) {
              return TicketItem(ticket);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Ticket {
  final DateTime dateTime;
  final String movieName, seatNumber;
  final int room;
  final barCode;

  Ticket(
      {this.dateTime,
      this.movieName,
      this.room,
      this.seatNumber,
      this.barCode});
}

class TicketItem extends StatelessWidget {
  final Ticket ticket;

  const TicketItem(this.ticket, {Key key}) : super(key: key);

  Widget _item(String label, String text) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, letterSpacing: 1),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xff263238),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Color(0xff546E7A),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      ticket.dateTime.day.toString(),
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Text(
                      Extras.monthToText(ticket.dateTime.month),
                      style: TextStyle(fontSize: 37, color: Colors.white),
                    ),
                    Text(
                      ticket.dateTime.year.toString(),
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ticket.movieName,
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontFamily: 'Anton'),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  _item("SALA: ", ticket.room.toString()),
                  _item("ASIENTO: ", ticket.seatNumber),
                  _item("HORA: ", ticket.seatNumber),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Constants.primaryColor),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Constants.primaryColor),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Constants.primaryColor),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Constants.primaryColor),
          ),
        ),
      ],
    );
  }
}
