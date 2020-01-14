
abstract class Store {
  List getFiltered();
  String getDescription();
}


abstract class StoreFilter extends Store{
  List getFiltered();
}


class Restaurant extends Store{
  List restaurantLists;
  String description = '';
  Restaurant(this.restaurantLists);

  List getFiltered() {
    return restaurantLists;
  }

  @override
  String getDescription() {
    return description;
  }
}

class RandomFilter extends StoreFilter{

  Store restaurant;

  RandomFilter(this.restaurant);

  @override
  List getFiltered() {
    List temp = restaurant.getFiltered();
    temp.shuffle();
    return temp;
  }

  @override
  String getDescription() {
    return restaurant.getDescription() + ' 랜덤 ';
  }

}



class BookmarkFilter extends StoreFilter{

  Store restaurant;

  BookmarkFilter(this.restaurant);

  @override
  List getFiltered() {
    List temp = restaurant.getFiltered();
    // 알고리즘 작성하기
    return temp;
  }

  @override
  String getDescription() {
    return restaurant.getDescription() + ' 북마크 ';
  }

}

class ExpensiveFilter extends StoreFilter{

  Store restaurant;

  ExpensiveFilter(this.restaurant);

  @override
  List getFiltered() {
    List temp = restaurant.getFiltered();
    // 알고리즘 작성하기
    return temp;
  }

  @override
  String getDescription() {
    return restaurant.getDescription() + ' 가격높음 ';
  }

}

class NearestFilter extends StoreFilter{

  Store restaurant;

  NearestFilter(this.restaurant);

  @override
  List getFiltered() {
    List temp = restaurant.getFiltered();
    // 알고리즘 작성하기
    return temp;
  }

  @override
  String getDescription() {
    return restaurant.getDescription() + ' 가까운곳 ';
  }

}

class CheapFilter extends StoreFilter{

  Store restaurant;

  CheapFilter(this.restaurant);

  @override
  List getFiltered() {
    List temp = restaurant.getFiltered();
    // 알고리즘 작성하기
    return temp;
  }

  @override
  String getDescription() {
    return restaurant.getDescription() + ' 가격낮음 ';
  }

}

class LiquorFilter extends StoreFilter{

  Store restaurant;

  LiquorFilter(this.restaurant);

  @override
  List getFiltered() {
    List temp = restaurant.getFiltered();
    // 알고리즘 작성하기
    return temp;
  }

  @override
  String getDescription() {
    return restaurant.getDescription() + ' 술파는곳 ';
  }
}

class CafeFilter extends StoreFilter{

  Store restaurant;

  CafeFilter(this.restaurant);

  @override
  List getFiltered() {
    List temp = restaurant.getFiltered();
    // 알고리즘 작성하기
    return temp;
  }

  @override
  String getDescription() {
    return restaurant.getDescription() + ' 카페 ';
  }
}