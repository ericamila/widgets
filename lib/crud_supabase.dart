import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'banco.dart';
import 'constants.dart';
import 'foto.dart';

class CRUDSupabase extends StatefulWidget {
  const CRUDSupabase({super.key});

  @override
  State<CRUDSupabase> createState() => _CRUDSupabaseState();
}

class _CRUDSupabaseState extends State<CRUDSupabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastros'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Pessoa>>(
            future: PessoaDao().findAll(),
            builder: (context, snapshot) {
              List<Pessoa>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return carregando;
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.separated(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Pessoa externo = items[index];
                          return ListTile(
                              title: Text(externo.nome),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: externo.foto != null
                                    ? Image.network(
                                  height: 58,
                                  width: 58,
                                  externo.foto!,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  color: Colors.grey,
                                  child: Image.asset(imagemPadraoUrl),
                                ),
                              ),
                              onTap: () {},
                              trailing: PopupMenuButton<bool>(
                                onSelected: (value) async {
                                  if (value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (contextNew) => FormCadastro(
                                          externoContext: context,
                                          externoEdit: externo,
                                          tipoCadastro: 'Cadastro',
                                        ),
                                      ),
                                    ).then((value) => setState(() {}));
                                  } else {
                                    bool deletedConfirmed = await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Deletar'),
                                          content: Text(
                                              'Tem certeza que deseja deletar ${externo.nome}?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: const Text('Cancelar'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              },
                                              child: const Text('Deletar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (deletedConfirmed) {
                                      await PessoaDao().delete(externo.id!);
                                      setState(() {});
                                    }
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<bool>>[
                                  const PopupMenuItem<bool>(
                                      value: true,
                                      child: ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text('Editar'),
                                      )),
                                  const PopupMenuItem<bool>(
                                      value: false,
                                      child: ListTile(
                                        leading: Icon(Icons.delete_forever),
                                        title: Text('Excluir'),
                                      )),
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                    }
                    return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 96,
                            ),
                            Text(
                              'Não há nenhum dado.',
                              style: TextStyle(fontSize: 32),
                            ),
                          ],
                        ));
                  }
                  return const Text('Erro ao carregar dados');
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormCadastro(
                  externoContext: context, tipoCadastro: 'Cadastro'),
            ),
          ).then((value) => setState(() {}));
        },
        label: const Text(
          'ADICIONAR',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.person_add),
      ),
    );
  }
}

class FormCadastro extends StatefulWidget {
  final BuildContext externoContext;
  final Pessoa? externoEdit;
  final String tipoCadastro;

  const FormCadastro(
      {super.key,
        required this.externoContext,
        this.externoEdit,
        required this.tipoCadastro});

  @override
  State<FormCadastro> createState() => _FormCadastroState();
}

class _FormCadastroState extends State<FormCadastro> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  String? _imageUrl;
  bool isEditar = false;
  var uuid = const Uuid();


  @override
  void initState() {
    super.initState();
    _seEditar();
  }

  @override
  void dispose() {
    nomeController.dispose();
    _imageUrl = '';
    super.dispose();
  }

  void _seEditar() {
    if (widget.externoEdit != null) {
      setState(() {
        nomeController.text = widget.externoEdit!.nome;
        _imageUrl = widget.externoEdit!.foto;
        isEditar = true;
      });
    }
  }


  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de ${widget.tipoCadastro}'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: paddingPadraoFormulario,
                  child: TextFormField(
                    validator: (String? value) {
                      if (valueValidator(value)) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    controller: nomeController,
                    textAlign: TextAlign.center,
                    decoration: myDecoration('Nome Completo'),
                  ),
                ),
                //N O V O
                Foto(
                    uUID: (isEditar)? widget.externoEdit?.id : uuid.v1(),
                    imageUrl: _imageUrl,
                    onUpload: (imageUrl) async {
                      if (!mounted) return;
                      setState(() {
                        _imageUrl = imageUrl;
                      });
                    }),
                space,
                FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // print('${nomeController.text}\n$_imageUrl');
                      PessoaDao().save(Pessoa(
                        nome: nomeController.text,
                        foto: (_imageUrl != '') ? _imageUrl : '',
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Salvando registro!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      setState(() {});
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PessoaDao {
static const String _tablename = 'pessoa';
static const String _nome = 'nome';
static const String _foto = 'foto';
static const String _id = 'id';

save(Pessoa model) async {
  var itemExists = await find(model.nome);
  Map<String, dynamic> modelMap = toMap(model);
  if (itemExists.isEmpty) {
    await supabase.from(_tablename).insert({
      'nome': model.nome,
      'foto': model.foto
    });
  } else {
    model.id = itemExists.last.id;
    await supabase
        .from(_tablename)
        .update(modelMap)
        .eq('id', model.id.toString());
  }
}

Map<String, dynamic> toMap(Pessoa model) {
  final Map<String, dynamic> mapa = {};
  mapa[_nome] = model.nome;
  mapa[_foto] = model.foto;
  return mapa;
}

Future<List<Pessoa>> findAll() async {
  final List<Map<String, dynamic>> result =
  await supabase.from(_tablename).select().order(_nome, ascending: true);
  return toList(result);
}

List<Pessoa> toList(List<Map<String, dynamic>> mapa) {
  final List<Pessoa> models = [];
  for (Map<String, dynamic> linha in mapa) {
    final Pessoa model = Pessoa(
      nome: linha[_nome],
      foto: linha[_foto],
      id: linha[_id],
    );
    models.add(model);
  }
  return models;
}

Future<List<Pessoa>> find(String nome) async {
  final List<Map<String, dynamic>> result =
  await supabase.from(_tablename).select().eq('nome', nome);
  return toList(result);
}

Future<Pessoa> findID(String id) async {
  final Map<String, dynamic> result =
  await supabase.from(_tablename).select().eq('id', id).single();
  final Pessoa model = Pessoa(
    nome: result[_nome],
    foto: result[_foto],
    id: result[_id],
  );
  return model;
}

delete(String id) async {
  return await supabase.from(_tablename).delete().eq('id', id);
}
}

class Pessoa{
  String? id;
  String nome;
  String? foto;

  Pessoa({required this.nome, this.foto, this.id});

  @override
  String toString() {
    return '$nome $foto $id';
  }
}
