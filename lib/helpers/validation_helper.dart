class ValidationHelper{
  ValidationHelper();

 static String? validatetitle(String? value){
  if(value=='' || value==null ||value.isEmpty){
    return 'please enter title';
  }
  return null;

  }
   static String? validateDescription(String? value){
  if(value=='' || value==null ||value.isEmpty){
    return 'please enter description';
  }
  return null;

  }
}