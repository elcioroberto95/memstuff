import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../helpers/validator_helper.dart';
import '../controllers/detail_controller.dart';
import '../core/app_const.dart';
import '../repositories/stuff_repository_impl.dart';
import '../widgets/date_input_field.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/photo_field_area.dart';
import '../widgets/primary_button.dart';
import '../widgets/text_input_field.dart';
import '../models/stuff_model.dart';
import '../helpers/snackbar_helper.dart';

class DetailPage extends StatefulWidget {
  final StuffModel stuff;

  const DetailPage({
    Key key,
    this.stuff,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = DetailController(StuffRepositoryImpl());

  @override
  void initState() {
    _controller.setId(widget.stuff?.id);
    _controller.setPhoto(widget.stuff?.photoPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stuff == null ? kTitleNewLoan : kTitleDetails),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: _buildForm(),
      ),
    );
  }

  _buildForm() {
    var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #########',
      filter: {"#": RegExp(r'[0-9]')},
    );
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PhotoInputArea(
            initialValue: widget.stuff?.photoPath ?? '',
            onChanged: _controller.setPhoto,
          ),
          TextInputField(
            label: kLabelDescription,
            icon: Icons.description_outlined,
            initialValue: widget.stuff?.description ?? '',
            onSaved: _controller.setDescription,
          ),
          TextInputField(
            label: kLabelName,
            icon: Icons.person_outlined,
            initialValue: widget.stuff?.contactName ?? '',
            onSaved: _controller.setName,
          ),
          TextFormField(
            initialValue: widget.stuff?.phone ?? '',
            onSaved: _controller.setPhone,
            decoration: InputDecoration(
              labelText: kLabelPhone,
              prefixIcon: Icon(Icons.phone),
            ),
            validator: ValidatorHelper.checkPhone,
            keyboardType: TextInputType.phone,
            inputFormatters: [maskFormatter],
          ),
          DateInputField(
            label: kLabelLoanDate,
            initialValue: widget.stuff?.date ?? '',
            onSaved: _controller.setDate,
          ),
          PrimaryButton(
            label: kButtonClean,
            onPressed: _onClean,
          ),
          PrimaryButton(
            label: kButtonSave,
            onPressed: _onSave,
          ),
        ],
      ),
    );
  }

  Future _onSave() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      LoadingDialog.show(
        context,
        message: widget.stuff == null ? 'Salvando...' : 'Atualizando...',
      );
      await _controller.save();
      LoadingDialog.hide();
      Navigator.of(context).pop();
      _onSucessMessage();
    }
  }

  void _onClean() {
    _formKey.currentState.reset();
  }

  _onSucessMessage() {
    if (widget.stuff == null) {
      SnackbarHelper.showCreateMessage(
        context: context,
        message: '${_controller.description} criado com sucesso!',
      );
    } else {
      SnackbarHelper.showUpdateMessage(
        context: context,
        message: '${_controller.description} atualizado com sucesso!',
      );
    }
  }
}
