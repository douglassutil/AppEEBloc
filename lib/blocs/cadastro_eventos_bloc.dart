import 'dart:io';

import 'package:loja/models/cadastro_eventos_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:loja/validadores.dart';


class CadastroEventosBloc extends Object with Validators implements BlocBase{

  final _cadastroModel = CadastroEventosModel();

  final _imagemEventoController = BehaviorSubject<File>();
  final _nomeEventoController = BehaviorSubject<String>();
  final _descricaoEventoController = BehaviorSubject<String>();
  final _horaEventoController = BehaviorSubject<String>();
  final _dataEventoController = BehaviorSubject<String>();
  final _numeroMinEventoController = BehaviorSubject<String>();
  final _numeroMaxEventoController = BehaviorSubject<String>();
  final _sexoEventoController = BehaviorSubject<String>();
  final _esporteEventoController = BehaviorSubject<String>();
  final _estacionamentoEventoController = BehaviorSubject<String>.seeded("n");
  final _eventoPagoEventoController = BehaviorSubject<String>.seeded("n");

  Sink<File> get imagemEventoEvent => _imagemEventoController.sink;
  Sink<String> get nomeEventoEvent => _nomeEventoController.sink;
  Sink<String> get descricaoEventoEvent => _descricaoEventoController.sink;
  Sink<String> get horaEventoEvent => _horaEventoController.sink;
  Sink<String> get dataEventoEvent => _dataEventoController.sink;
  Sink<String> get numeroMinEventoEvent => _numeroMinEventoController.sink;
  Sink<String> get numeroMaxEventoEvent => _numeroMaxEventoController.sink;
  Sink<String> get sexoEventoEvent => _sexoEventoController.sink;
  Sink<String> get esporteEventoEvent => _esporteEventoController.sink;
  Sink<String> get estacionamentoEventoEvent => _estacionamentoEventoController.sink;
  Sink<String> get eventoPagoEventoEvent => _eventoPagoEventoController.sink;
  
  Observable<File> get imagemEventoFlux => _imagemEventoController.stream;
  Observable<String> get nomeEventoFlux => _nomeEventoController.stream.transform(nomeEventoValidator);
  Observable<String> get descricaoEventoFlux => _descricaoEventoController.stream.transform(descricaoEventoValidator);
  Observable<String> get horaEventoFlux => _horaEventoController.stream;
  Observable<String> get dataEventoFlux => _dataEventoController.stream;
  Observable<String> get numeroMinEventoFlux => _numeroMinEventoController.stream;
  Observable<String> get numeroMaxEventoFlux => _numeroMaxEventoController.stream;
  Observable<String> get sexoEventoFlux => _sexoEventoController.stream;
  Observable<String> get estacionamentoEventoFlux => _estacionamentoEventoController.stream;
  Observable<String> get eventoPagoEventoFlux => _eventoPagoEventoController.stream;
  Observable<String> get esporteEventoFlux => _esporteEventoController.stream.transform(esporteEventoValidator);

  void horaEventoValidador(hora) => validaHoraEvento(hora,_horaEventoController);
  void dataEventoValidador(data) => validaDataEvento(data,_dataEventoController);

  List<String> sexo = ['Masculino', 'Feminino', 'Unissex'];
  File imagemFile;  
 
  Observable<bool> get submitFirstCheck => Observable.combineLatest5(nomeEventoFlux, descricaoEventoFlux,esporteEventoFlux, numeroMaxEventoFlux,dataEventoFlux, (a,b,c,d,e)=>true);

  void salvar(){
    if ( _nomeEventoController.value == null || _descricaoEventoController.value == null || 
    _horaEventoController.value == null || _dataEventoController.value == null ||
    _numeroMinEventoController.value == null || _numeroMaxEventoController.value == null || 
    _sexoEventoController.value == null || _esporteEventoController.value == null || 
    _imagemEventoController.value == null )
    {
        print("alguém vazio");
    }

  }

  void getImage() async {
    var imagem = await _cadastroModel.getImage();
    _imagemEventoController.add(imagem);
  }

  @override
  void dispose() {
    _nomeEventoController?.close();
    _descricaoEventoController?.close();
    _horaEventoController?.close();
    _dataEventoController?.close();
    _numeroMinEventoController?.close();
    _numeroMaxEventoController?.close();
    _sexoEventoController?.close();
    _esporteEventoController?.close();
    _estacionamentoEventoController?.close();
    _eventoPagoEventoController?.close();
    _imagemEventoController?.close();
  }

}
