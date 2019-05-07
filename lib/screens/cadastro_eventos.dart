import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:loja/blocs/cadastro_eventos_bloc.dart';

class CadastroEventos extends StatefulWidget {
  @override
  _CadastroEventosState createState() => _CadastroEventosState();
}

class _CadastroEventosState extends State<CadastroEventos> {

  TextEditingController nomeController = TextEditingController();
  var horaController = MaskedTextController(text: 'HH:mm',mask: '00:00');
  var dataController = MaskedTextController(text: '',mask: '00/00/0000');
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController esporteController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CadastroEventosBloc _cadastroEventosBloc;

  @override
  void initState() {
    super.initState();
    nomeController.addListener(setName);
    horaController.addListener(setHora);
    dataController.addListener(setData);
    minController.addListener(setMin);
    maxController.addListener(setMax);
    esporteController.addListener(setEsporte);
    descricaoController.addListener(setDescricao);
    _cadastroEventosBloc = CadastroEventosBloc();
  }

  @override
  void dispose() {
    nomeController.dispose();
    horaController.dispose();
    dataController.dispose();
    minController.dispose();
    maxController.dispose();
    esporteController.dispose();
    descricaoController.dispose();
    _cadastroEventosBloc.dispose();
    super.dispose();
  }

  setName() => _cadastroEventosBloc.nomeEventoEvent.add(nomeController.text);
  setHora() => _cadastroEventosBloc.horaEventoEvent.add(horaController.text);
  setData() => _cadastroEventosBloc.dataEventoEvent.add(dataController.text);
  setMin() => _cadastroEventosBloc.numeroMinEventoEvent.add(minController.text);
  setMax() => _cadastroEventosBloc.numeroMaxEventoEvent.add(maxController.text);
  setEsporte() => _cadastroEventosBloc.esporteEventoEvent.add(esporteController.text);
  setDescricao() => _cadastroEventosBloc.descricaoEventoEvent.add(descricaoController.text);
  

  @override
  Widget build(BuildContext context) {
    
    var contentPaddingVerticalDropDown = MediaQuery.of(context).size.width * 0.03;
    var contentPaddingVertical = MediaQuery.of(context).size.width * 0.035;
    var contentPaddingHorizontal = MediaQuery.of(context).size.width * 0.02;
    
    final paddingBotton = MediaQuery.of(context).size.width * 0.02;
    final paddingBottonError = (MediaQuery.of(context).size.width * 0.02) + 22.0;  

    return Scaffold(
      
      appBar: AppBar(
        title: Text("Cadastro de Eventos"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child:Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              StreamBuilder(
                stream: _cadastroEventosBloc.imagemEventoFlux ,
                initialData: null ,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),

                    width: MediaQuery.of(context).size.width * 0.58,
                    height: MediaQuery.of(context).size.width * 0.48,
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.15,
                        snapshot.data == null ? 0 : MediaQuery.of(context).size.width * 0.03,
                        MediaQuery.of(context).size.width * 0.15,
                        MediaQuery.of(context).size.width * 0.0),
                        
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),

                      child: snapshot.data == null 
                        ? IconButton(
                          icon: Icon(
                            Icons.insert_photo, 
                            color: Colors.green, 
                            size: MediaQuery.of(context).size.width * 0.48,
                          ),
                          onPressed: () => _cadastroEventosBloc.getImage()
                        )
                        : InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.width * 0.48,

                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2.0,
                                  style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                child: Image.file(snapshot.data, fit:BoxFit.cover),
                              )                            
                              
                            ),
                            onTap: () => _cadastroEventosBloc.getImage()
                          )
                      ,
                    ),
                  );
                },
              ),

              StreamBuilder(
                stream: _cadastroEventosBloc.nomeEventoFlux,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

                  return Container(
                    padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.01,
                      MediaQuery.of(context).size.width * 0.03,
                      MediaQuery.of(context).size.width * 0.01,
                      paddingBotton
                    ),
                    child: TextFormField(
                      controller: nomeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Digite o Nome do Evento",
                        labelText: "Nome Evento",
                        errorText: snapshot.error,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: contentPaddingVertical,
                          horizontal: contentPaddingHorizontal
                        ),
                      ),
                      validator: (value) {
                        if (value.length >= 50) {
                          return 'Digite no máximo 50 caracteres!';
                        }else if(value.isEmpty){
                          return 'Digite o Nome do Evento!';
                        }
                      }
                    )
                  );
                },
              ),

              Row(
                children: <Widget>[

                  StreamBuilder(
                    stream: _cadastroEventosBloc.horaEventoFlux,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      return Container(

                        width: MediaQuery.of(context).size.width * 0.5,
                    
                        padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.01,
                          MediaQuery.of(context).size.width * 0.03,
                          MediaQuery.of(context).size.width * 0.01,
                          paddingBotton
                        ),
                        child: TextFormField(
                          controller: horaController,
                          onFieldSubmitted: (s) => _cadastroEventosBloc.horaEventoValidador(s),
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: 0),
                            border: OutlineInputBorder(),
                            labelText: "Horário",
                            hintText: "HH:mm",
                            errorText: snapshot.error,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: contentPaddingVertical,
                              horizontal: contentPaddingHorizontal
                            ),
                          ),
                          validator: (value) {
                            if (value.length != 5) {
                              return 'Horário inválido';
                            }else if(value.isEmpty){
                              return 'Digite um Horário!';
                            }
                          },
                        ),
                      );
                    },
                  ),
                  
                  StreamBuilder(
                    stream: _cadastroEventosBloc.dataEventoFlux,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      return Container(

                        width: MediaQuery.of(context).size.width * 0.5,
                        
                        padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.01,
                          MediaQuery.of(context).size.width * 0.03,
                          MediaQuery.of(context).size.width * 0.01,
                          paddingBotton
                        ),
                        child: TextFormField(
                          controller: dataController,
                          onFieldSubmitted: (s) => _cadastroEventosBloc.dataEventoValidador(s),
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: 0),
                            border: OutlineInputBorder(),
                            labelText: "Data Evento",
                            hintText: "Data do Evento",
                            errorText: snapshot.error,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: contentPaddingVertical,
                              horizontal: contentPaddingHorizontal
                            ),
                          ),
                          validator: (value) {
                            if (value.length < 10) {
                              return 'Data inválida';
                            }else if(value.isEmpty){
                              return 'Digite a Data do Evento!';
                            }
                          },
                        ),
                      );
                    },
                  ),

                ],
              ),

              Row(
                children: <Widget>[

                  StreamBuilder(
                    stream: _cadastroEventosBloc.numeroMinEventoFlux,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,

                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.width * 0.03,
                            MediaQuery.of(context).size.width * 0.01,
                            paddingBotton),
                        child: TextFormField(
                          controller: minController,
                          onFieldSubmitted: (s) => _cadastroEventosBloc.numeroMinEventoEvent.add(s),
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: 0),
                            border: OutlineInputBorder(),
                            hintText: "Nº Min Participantes",
                            labelText: "Nº Min Participantes",
                            errorText: snapshot.error,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: contentPaddingVertical,
                              horizontal: contentPaddingHorizontal
                            ),
                          ),
                          validator: (value) {
                            if(value.isEmpty){
                              return '0 (zero) para Ilimitado';
                            }
                          },
                        ),
                      );
                    },
                  ),

                  StreamBuilder(
                    stream: _cadastroEventosBloc.numeroMaxEventoFlux,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,

                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.width * 0.03,
                            MediaQuery.of(context).size.width * 0.01,
                            paddingBotton),
                        child: TextFormField(
                          controller: maxController,
                          onFieldSubmitted: (s) => _cadastroEventosBloc.numeroMaxEventoEvent.add(s),
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: 0),
                            border: OutlineInputBorder(),
                            hintText: "Nº Max Participantes",
                            labelText: "Nº Max Participantes",
                            errorText: snapshot.error,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: contentPaddingVertical,
                              horizontal: contentPaddingHorizontal
                            ),
                          ),
                          validator: (value) {
                            if(value.isEmpty){
                              return '0 (zero) para Ilimitado';
                            }
                          },
                        ),
                      );
                    },
                  ),              

                ],
              ),

              Row(
                children: <Widget>[

                  StreamBuilder(
                    stream: _cadastroEventosBloc.sexoEventoFlux,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.width * 0.03,
                            MediaQuery.of(context).size.width * 0.01,
                            paddingBotton),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Sexo",
                            hintText: "Selecione o Sexo",
                            contentPadding: EdgeInsets.symmetric(
                              vertical: contentPaddingVerticalDropDown,
                              horizontal: contentPaddingHorizontal
                            ),
                          ),                      
                          value: snapshot.data,
                          onChanged: (newValue) => _cadastroEventosBloc.sexoEventoEvent.add(newValue),
                          items: _cadastroEventosBloc.sexo.map((sexo) {
                            return DropdownMenuItem(
                              child: Text(sexo),
                              value: sexo,
                            );
                          }).toList(),
                          validator: (value){
                            if (value != "Masculino" && value != "Feminino" && value != "Unissex") {
                              return 'Selecione o Sexo';
                            }
                          },
                        ),
                      );
                    },
                  ),

                  StreamBuilder(
                    stream: _cadastroEventosBloc.esporteEventoFlux,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,

                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.width * 0.03,
                            MediaQuery.of(context).size.width * 0.01,
                            paddingBotton),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: esporteController,
                          onFieldSubmitted: (s) => _cadastroEventosBloc.esporteEventoEvent.add(s),
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: 0),
                            border: OutlineInputBorder(),
                            hintText: "Esporte",
                            labelText: "Esporte",
                            errorText: snapshot.error,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: contentPaddingVertical,
                              horizontal: contentPaddingHorizontal
                            ),
                          ),
                          validator: (value){
                            if (value.isEmpty) {
                              return 'Digite o Esporte!';
                            }
                          },
                        ),
                      );
                    },
                  ),   
                ],
              ),

              Row(
                children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.01,
                        MediaQuery.of(context).size.width * 0.03,
                        MediaQuery.of(context).size.width * 0.01,
                        paddingBotton),

                    child: Container(   
                      
                      padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.02,
                        MediaQuery.of(context).size.width * 0.025,
                        MediaQuery.of(context).size.width * 0.01,
                        0),

                      decoration: BoxDecoration(
                        border: Border.all(width: 1.2,color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Estacionamento ?',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              StreamBuilder(
                                stream: _cadastroEventosBloc.estacionamentoEventoFlux ,
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                  return Radio(
                                    activeColor: Colors.green,
                                    value: 's',
                                    groupValue: snapshot.data,
                                    onChanged: (s) => _cadastroEventosBloc.estacionamentoEventoEvent.add(s),
                                  );
                                },
                              ),
                              Text(
                                'Sim',
                                style: TextStyle(fontSize: 14.0),
                              ),

                              StreamBuilder(
                                stream: _cadastroEventosBloc.estacionamentoEventoFlux ,
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                  return Radio(
                                    activeColor: Colors.red,
                                    value: 'n',
                                    groupValue: snapshot.data,
                                    onChanged: (s) => _cadastroEventosBloc.estacionamentoEventoEvent.add(s),
                                  );
                                },
                              ),
                              Text(
                                'Não',
                                style: TextStyle(fontSize: 14.0),
                              ),                       
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.01,
                        MediaQuery.of(context).size.width * 0.03,
                        MediaQuery.of(context).size.width * 0.01,
                        paddingBotton),

                    child: Container(

                      padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.02,
                        MediaQuery.of(context).size.width * 0.025,
                        MediaQuery.of(context).size.width * 0.01,
                        0),
                      
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.2,color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Evento Pago ?',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              StreamBuilder(
                                stream: _cadastroEventosBloc.eventoPagoEventoFlux ,
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                  return Radio(
                                    activeColor: Colors.green,
                                    value: 's',
                                    groupValue: snapshot.data,
                                    onChanged: (s) => _cadastroEventosBloc.eventoPagoEventoEvent.add(s),
                                  );
                                },
                              ),
                              Text(
                                'Sim',
                                style: TextStyle(fontSize: 14.0),
                              ),

                              StreamBuilder(
                                stream: _cadastroEventosBloc.eventoPagoEventoFlux ,
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                  return Radio(
                                    activeColor: Colors.red,
                                    value: 'n',
                                    groupValue: snapshot.data,
                                    onChanged: (s) => _cadastroEventosBloc.eventoPagoEventoEvent.add(s),
                                  );
                                },
                              ),
                              Text(
                                'Não',
                                style: TextStyle(fontSize: 14.0),
                              ),                       
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              StreamBuilder(
                stream: _cadastroEventosBloc.descricaoEventoFlux,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return Container(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.01,
                        MediaQuery.of(context).size.width * 0.03,
                        MediaQuery.of(context).size.width * 0.01,
                        paddingBotton),
                    child: TextFormField(
                      controller: descricaoController,
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      maxLength: 300,
                      onFieldSubmitted: (s) => _cadastroEventosBloc.descricaoEventoEvent.add(s),
                      decoration: InputDecoration(
                        counterText: "",
                        counterStyle: TextStyle(fontSize: 0),
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                        labelText: "Descrição",
                        hintText: "Digite uma Descrição para o Evento",
                        errorText: snapshot.error,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: contentPaddingVertical,
                          horizontal: contentPaddingHorizontal
                        ),
                      ),
                      validator: (value) {
                        if (value.length > 300) {
                          return 'Máximo 300 caracteres';
                        }else if(value.isEmpty){
                          return 'Digite uma Descrição!';
                        }
                      },
                    ),
                  );
                },
              ),
              
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.1,

                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02),

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0,
                      style: BorderStyle.solid
                    ),
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      IconButton(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.001),
                        icon: Icon(Icons.save,color: Colors.white,size: MediaQuery.of(context).size.width * 0.07,), 
                        onPressed: (){}
                      ),

                      Container(
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20
                          ),
                        ),
                      )
                    ],
                  ),                
                ),
                onTap: (){  if (_formKey.currentState.validate() == true) 
                              _cadastroEventosBloc.salvar();
                          }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
