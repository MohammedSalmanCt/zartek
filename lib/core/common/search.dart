setSearchParam(List<String> search){
 List<String> searchList=[];
 for(String s in search){
    for (int i = 0; i <= s.length; i++) {
      for (int j = i + 1; j <= s.length; j++) {
        searchList.add(s.substring(i, j).toUpperCase().trim());
      }
    }
  }
  return searchList;
}