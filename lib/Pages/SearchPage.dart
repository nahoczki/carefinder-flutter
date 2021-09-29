import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:smart_select/smart_select.dart';

import '../Components/Filter Chip/CustomFilterChip.dart';
import '../Components/Hospital Card/HospitalCard.dart';
import '../DataProvider/HospitalProvider.dart';
import '../DataProvider/Hospital.dart';


class SearchPage extends StatefulWidget {

  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final HospitalProvider provider = new HospitalProvider();
  var _controller = TextEditingController();
  var _cityController = TextEditingController();


  List<Hospital> _searchResults = [];

  String _cityText = "";
  String _stateText = "";

  String _selected = "ID";
  bool _isLoading = false;

  void setSelected(String newSelect) {
    _controller.clear();
    setState(() {
      this._selected = newSelect;
    });
  }

  void submitSearch(String searchText) {
    _controller.clear();
    String eSearchText = searchText.toUpperCase();

    this.setState(() {
      this._isLoading = true;
    });

    if (_selected == "City / State") {
      eSearchText = '${_cityText.toUpperCase()},${_stateText.toUpperCase()}';
    }

    provider.searchHospital(_selected, eSearchText).then((res) => {
      this.setState(() {
        this._searchResults = res;
        this._isLoading = false;
      })
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    color: Colors.grey[200],
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                _selected == "City / State" ? Flexible(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: TextField(
                                              controller: _cityController,
                                              onChanged: (text) {
                                                setState(() {
                                                  this._cityText = text;
                                                });
                                              },
                                              textInputAction: TextInputAction.next,
                                              style: TextStyle(color: Colors.grey[800], fontSize: 16.0),
                                              decoration: InputDecoration(
                                                hintText: "City",
                                                contentPadding: EdgeInsets.all(10.0),
                                                prefixIcon: Icon(FeatherIcons.search, size: 17),
                                                enabledBorder: OutlineInputBorder(
                                                  // width: 0.0 produces a thin "hairline" border
                                                  borderSide: BorderSide(color: Colors.grey[500]),
                                                ),
                                                border: OutlineInputBorder(),
                                                fillColor: Colors.white,
                                                filled: true,
                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Flexible(
                                          child: TextField(
                                            controller: _controller,
                                              onChanged: (text) {
                                                setState(() {
                                                  this._stateText = text;
                                                });
                                              },
                                              onSubmitted: (text) {
                                                submitSearch(text);
                                              },
                                              textInputAction: TextInputAction.search,
                                              style: TextStyle(color: Colors.grey[800], fontSize: 16.0),
                                              decoration: InputDecoration(
                                                hintText: "State",
                                                contentPadding: EdgeInsets.all(10.0),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey[500]),
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: (() => {
                                                    _controller.clear(),
                                                    _cityController.clear()
                                                  }),
                                                  icon: Icon(Icons.clear),
                                                ),
                                                border: OutlineInputBorder(),
                                                fillColor: Colors.white,
                                                filled: true,
                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                              )
                                          ),
                                        )
                                      ],
                                    )
                                ) : Flexible(
                                  child: TextField(
                                      controller: _controller,
                                      autofocus: true,
                                      onSubmitted: (text) {
                                        submitSearch(text);
                                      },
                                      textInputAction: TextInputAction.search,
                                      style: TextStyle(color: Colors.grey[800], fontSize: 16.0),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10.0),
                                        prefixIcon: Icon(FeatherIcons.search, size: 17),
                                        enabledBorder: OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderSide: BorderSide(color: Colors.grey[500]),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: _controller.clear,
                                          icon: Icon(Icons.clear),
                                        ),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.white,
                                        filled: true,
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                      )
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: InkWell(
                                    onTap: () => (
                                        Navigator.of(context).pop()
                                    ),
                                    child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14.0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                children: [
                                  InkWell(
                                      enableFeedback: false,
                                      onTap: () => (setSelected("ID")),
                                      child: CustomFilterChip("ID", _selected)
                                  ),
                                  InkWell(
                                      enableFeedback: false,
                                      onTap: () => (setSelected("Name")),
                                      child: CustomFilterChip("Name", _selected)
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                      enableFeedback: false,
                                      onTap: () => (setSelected("City")),
                                      child: CustomFilterChip("City", _selected)
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                      enableFeedback: false,
                                      onTap: () => (setSelected("State")),
                                      child: CustomFilterChip("State", _selected)
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                      enableFeedback: false,
                                      onTap: () => (setSelected("County")),
                                      child: CustomFilterChip("County", _selected)
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                      enableFeedback: false,
                                      onTap: () => (setSelected("City / State")),
                                      child: CustomFilterChip("City / State", _selected)
                                  ),
                                ],
                              ),
                            )
                        )
                      ],
                    )
                ),
              ),
              Expanded(
                  flex: 8,
                  child: _isLoading ? Center(
                      child: CircularProgressIndicator()
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 20, top: 13, bottom: 13),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[50],
                              border: Border(
                                  top: BorderSide(
                                    color: Colors.grey[300],
                                    width: 1.0,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 1.0,
                                  )
                              )
                          ),
                          child: Text(_searchResults.length == 0 ? "No results found!" : "Results: ${_searchResults.length}", style: Theme.of(context).textTheme.overline)
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.only(top: 0),
                          itemCount: _searchResults.length,
                          itemBuilder: (context, position) {
                            return HospitalCard(_searchResults[position]);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 0,
                              color: Colors.grey[500],
                            );
                          },
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
