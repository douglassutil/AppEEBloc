import 'dart:async';

mixin Validators {

  var emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
      String emailValidationRule = r'^(([^()[\]\\.,;:\s@\"]+(\.[^()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(emailValidationRule);
    
      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Favor, entrar com um e-mail válido');
      }
    }
  );

  void validaNomeEvento (nomeEvento, nomeEventoController){
    if(nomeEvento.length > 30)
      nomeEventoController.addError("O nome não pode ter mais de 30 caracteres!");
    else{
      nomeEventoController.add(nomeEvento);        
    }    
  }

  void validaHoraEvento (horaEvento, horaEventoController){
    String horaValidationRule = r'^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$';
    RegExp regExp = new RegExp(horaValidationRule);
    if (regExp.hasMatch(horaEvento)) {
      horaEventoController.add(horaEvento);
    } else {
      horaEventoController.addError('Hora Inválida!');
    }  
  }

  void validaDataEvento (dataEvento, dataEventoController){
    String dataValidationRule = r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';
    RegExp regExp = new RegExp(dataValidationRule);
    if (regExp.hasMatch(dataEvento)) {
      dataEventoController.add(dataEvento);
    } else {
      dataEventoController.addError('Data Inválida!');
    }  
  }  

  var nomeEventoValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (nomeEvento,sink){
      if(nomeEvento.length > 30)
        sink.addError("O nome não pode ter mais de 30 caracteres!");
      else{
        sink.add(nomeEvento);        
      }
    }
  );

  var esporteEventoValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (esporteEvento,sink){
      if(esporteEvento.length > 25)
        sink.addError("Máximo 25 caracteres!");
      else{
        sink.add(esporteEvento);        
      }
    }
  );

  void validaDescricaoEvento (descricaoEvento, descricaoEventoController){
    if(descricaoEvento.length > 300)
      descricaoEventoController.addError("O nome não pode ter mais de 300 caracteres!");
    else{
      descricaoEventoController.add(descricaoEvento);        
    } 
  }

  var descricaoEventoValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (descricaoEvento,sink){
      if(descricaoEvento.length > 300)
        sink.addError("O nome não pode ter mais de 300 caracteres!");
      else{
        sink.add(descricaoEvento);        
      }
    }
  );

  var passwordValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length > 4)
        sink.add(password);
      else{
        sink.addError("Senha deve ter no mínimo 4 caracteres!");
      }
    }
  );

}