import 'package:flutter/material.dart';
import 'package:loja/blocs/cadastro_eventos_bloc.dart';

class CadastroEventos extends StatefulWidget {
  @override
  _CadastroEventosState createState() => _CadastroEventosState();
}

class _CadastroEventosState extends State<CadastroEventos> {

  CadastroEventosBloc _cadastroEventosBloc;

  @override
  void initState() {
    _cadastroEventosBloc = CadastroEventosBloc();
    super.initState();
  }

  @override
  void dispose() {
    _cadastroEventosBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _formKeyCadastroEventos = GlobalKey<FormState>();

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
          key: _formKeyCadastroEventos,
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
                        MediaQuery.of(context).size.width * 0.03,
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
                    child: TextField(
                      onChanged: (s) => _cadastroEventosBloc.nomeEventoEvent.add(s),
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
                        child: TextField(
                          controller: _cadastroEventosBloc.horaController,
                          onSubmitted:(s) => _cadastroEventosBloc.horaEventoValidador(s),
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
                        child: TextField(
                          controller: _cadastroEventosBloc.dataController,
                          onSubmitted:(s) => _cadastroEventosBloc.dataEventoValidador(s),
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
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (s) => _cadastroEventosBloc.esporteEventoEvent.add(s),
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
                    child: TextField(
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      maxLength: 300,
                      onChanged: (s) => _cadastroEventosBloc.descricaoEventoEvent.add(s),
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
                onTap: () => _cadastroEventosBloc.salvar()
,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
