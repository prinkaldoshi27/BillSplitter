import 'package:flutter/material.dart';
void main() {
  runApp(
    MaterialApp(
      // theme: _appTheme,
      home: BillSplitter(),
    ),
  );
}
class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  // Color _purple = HexColor("4A148CFF");
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(227, 181, 231, 1.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  height: 200,
                  width: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Per Person",
                          style: TextStyle(
                            color: Colors.purple.shade900,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                          style: TextStyle(
                            color: Colors.purple.shade900,
                            fontWeight: FontWeight.w900,
                            fontSize: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(children: [
                      TextField(
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 86, 32, 189),
                        ),
                        decoration: const InputDecoration(
                          prefixText: "Bill Amount  ",
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Color.fromARGB(255, 86, 32, 189),
                          ),
                        ),
                        onChanged: (String value) {
                          try {
                            _billAmount = double.parse(value);
                          } catch (exception) {
                            _billAmount = 0.0;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Split",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(
                                            () {
                                          if (_personCounter > 1) {
                                            _personCounter--;
                                          }
                                        },
                                      );
                                    },
                                    child: (Container(
                                      width: 40.0,
                                      height: 40,
                                      margin: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(7.0),
                                        color:
                                        Color.fromRGBO(227, 181, 231, 1.0),
                                      ),
                                      child: const Center(
                                        child: (Text(
                                          "-",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 86, 32, 189),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17.0,
                                          ),
                                        )),
                                      ),
                                    )),
                                  ),
                                  Text(
                                    "$_personCounter",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromARGB(255, 86, 32, 189),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _personCounter++;
                                      });
                                    },
                                    child: (Container(
                                      width: 40.0,
                                      height: 40,
                                      margin: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(7.0),
                                        color:
                                        Color.fromRGBO(227, 181, 231, 1.0),
                                      ),
                                      child: const Center(
                                        child: (Text(
                                          "+",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 86, 32, 189),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17.0,
                                          ),
                                        )),
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tip",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              " \$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 86, 32, 189),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //sliderr
                      Column(
                        children: [
                          Text(
                            "$_tipPercentage%",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 86, 32, 189),
                            ),
                          ),
                          Slider(
                              min: 0,
                              max: 100,
                              divisions: 10,
                              activeColor: Color.fromARGB(255, 86, 32, 189),
                              inactiveColor: Color.fromRGBO(227, 181, 231, 1.0),
                              value: _tipPercentage.toDouble(),
                              onChanged: (double newValue) {
                                setState(() {
                                  _tipPercentage = newValue.round();
                                });
                              })
                        ],
                      ),
                    ])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      //do nthng
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
      return totalTip;
    }
  }
}