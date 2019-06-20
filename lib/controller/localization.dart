class LocID{
  String store;
  String id;

  LocID(String stringID){
    analizeID(stringID);
  }

  void analizeID(String id)
  {

  }

  
}

class LocalizedStore{
  String storeID;
  Map<String, String> data;
  LocalizedStore(String storeID)
  {
    this.storeID = storeID;    
    _fromJSON();
  }
  
  _fromJSON(){

  }
}

class Localization{

  int idxLang = 0;
  List<String> langs = ["vn", "en"];

  List<String> storeIDs = ["menu", "setting"];

  Map<String,LocalizedStore> dataStores = Map();

  Localization(){
    _createDefaultDataStore();
    

  }

  _createDefaultDataStore(){
    dataStores = Map();
    for(int i = 0; i < storeIDs.length; i++)
      dataStores[storeIDs[i]] = null;
  }

  String fromString(String stringID){
    LocID locID = LocID(stringID);
    if(dataStores[locID.store] == null){
      dataStores[locID.store] = LocalizedStore(locID.store);
    }
    return dataStores[locID.store].data[locID.id];
  }

}