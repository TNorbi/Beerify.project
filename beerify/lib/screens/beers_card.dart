/*import 'package:flutter/material.dart';
import 'package:beerify/screens/beer.dart';

// A widget to display Beer cards in a list with sorting and filtering functionalities

class BeerList extends StatefulWidget {
  BeerList({Key? key, required this.beers}) : super(key: key);

  List<Beer> beers = [];

  @override
  _BeerListState createState() => _BeerListState();
}

enum SortingBy { name, brand }

class _BeerListState extends State<BeerList> {
  List<Beer> beers = [];
  bool _isAscending = true;
  SortingBy _sortingBy = SortingBy.name;
  List<String> _sortingByTexts = [];

  @override
  void initState() {
    // TODO: replace dummies with beers from contructor via database
    beers = [
      Beer(name: 'Ciuc', brand: 'Retro'),
      Beer(name: 'Ciuc', brand: 'Carpatica'),
      Beer(name: 'Ciuc', brand: 'Madness'),
      Beer(name: 'Ciuc', brand: 'Amazing'),
      Beer(name: 'Ciuc', brand: 'Unbelievable Tasty, but still Ciuc beer'),
      Beer(name: 'Ciuc', brand: 'NemFinomabbMintACsiki'),
      Beer(name: 'Heineken', brand: 'Salalala'),
      Beer(name: 'Heineken', brand: 'Funky'),
      Beer(name: 'Csiki', brand: 'DrunkFest'),
      Beer(name: 'Csiki', brand: 'PartyBrandBoooooys')
    ];

    // set default sorting and filtering
    _sortingBy = SortingBy.name;
    _changeSortingBy(_sortingBy);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sortingByTexts = [
      "Beer name",
      "Brand",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    // Change sorting order
                    _isAscending = !_isAscending;
                    //filteredChallenges = filteredChallenges.reversed.toList();
                  });
                },
                icon: Icon(
                    _isAscending ? Icons.arrow_downward : Icons.arrow_upward,
                    size: 18.0,
                    color: Theme.of(context).primaryColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sorting by ${_sortingByTexts.elementAt(_sortingBy.index)}',
                    style: TextStyle(color: Theme.of(context).disabledColor),
                  ),
                  IconButton(
                    onPressed: () async {
                      //await showSortByDialog(context);
                    },
                    icon: Icon(Icons.sort),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Container(
                    color: Colors.red,
                    //TODO Change color, if the filter is active
                    /*_filtersActive()
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,

                     */
                    child: IconButton(
                      onPressed: () async {
                        //await showFilterDialog(context);
                      },
                      icon: Icon(Icons.filter_alt,
                          //TODO change color, if filter is active
                          /*
                          _filtersActive()
                          ? Icons.filter_alt
                          : Icons.filter_alt_outlined),

                         */
                          color: Colors.lightGreen
                          //TODO change color, if filter is active
                          /*

                          _filtersActive()
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.primary,
                          */
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        /*
    Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
            child: ListView.builder(
              // TODO: by default, show the last 10 beers from database
              //itemCount: filteredChallenges.length <= 20
                  //? filteredChallenges.length
                  //: 20,
              itemBuilder: (BuildContext ctx, int index) {
                return ChallengeCard(
                  challenge: filteredChallenges[index],
                  onCardClick: () {
                    // TODO: navigate to details screen


                  },
                 );
              },
            ),
          ),
        ),
    */
      ],
    );
  }

  void _changeSortingBy(SortingBy sortingBy) {
    setState(() {
      _sortingBy = sortingBy;
      switch (_sortingBy) {
        case SortingBy.name:
          beers.sort((a, b) {
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });
          _isAscending = true;
          break;
      }
    });
  }

/*
  Future<void> showSortByDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(S.of(context).sortBy),
          children: [
            Container(
              color: _sortingBy == SortingBy.Title
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
                  : Colors.transparent,
              child: SimpleDialogOption(
                onPressed: () {
                  _changeSortingBy(SortingBy.Title);
                  Navigator.of(context).pop(context);
                },
                child: Text(S.of(context).title,
                    style: const TextStyle(fontSize: 16.0)),
              ),
            ),
            Container(
              color: _sortingBy == SortingBy.CreationDate
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
                  : Colors.transparent,
              child: SimpleDialogOption(
                onPressed: () {
                  _changeSortingBy(SortingBy.CreationDate);
                  Navigator.of(context).pop(context);
                },
                child: Text(S.of(context).creationDate,
                    style: const TextStyle(fontSize: 16.0)),
              ),
            ),
            Container(
              color: _sortingBy == SortingBy.Popularity
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
                  : Colors.transparent,
              child: SimpleDialogOption(
                onPressed: () {
                  _changeSortingBy(SortingBy.Popularity);
                  Navigator.of(context).pop(context);
                },
                child: Text(S.of(context).popularity,
                    style: const TextStyle(fontSize: 16.0)),
              ),
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  }
  */

/*
  Future<void> showFilterDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return ChallengeFilterDialog(
            challenges: dummyChallenges,
            currentCategoryFilters: _categoryFilters,
            currentCreatorFilters: _creatorFilters,
            currentDateRange: _dateRangeFilter,
            onFilteringFinished:
                (categoryFilters, creatorFilters, dateRangeFilter) =>
                    _applyFilters(
                        categoryFilters, creatorFilters, dateRangeFilter));
      },
      barrierDismissible: false,
    );
  }
*/

/*
  void _applyFilters(categoryFilters, creatorFilters, dateRangeFilter) {
    setState(() {
      _categoryFilters = categoryFilters;
      _creatorFilters = creatorFilters;
      _dateRangeFilter = dateRangeFilter;
    });
    // TODO: filter and refresh challenge list
  }

  bool _filtersActive() {
    if (_categoryFilters.isEmpty &&
        _creatorFilters.isEmpty &&
        _dateRangeFilter == null)
      return false;
    else
      return true;
  }
}

*/

}


 */