import 'package:flutter/material.dart';
import 'package:jotstcg/controller/auth_controller.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String accessToken;

  const ResetPasswordScreen({
    super.key,
    required this.accessToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _authController = AuthController();
  bool _isLoading = false;

  @override
  void dispose() {
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      await _authController.updateUserPassword(
        accessToken: widget.accessToken,
        newPassword: _senhaController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Senha redefinida com sucesso! Você já pode fazer o login.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: ${e.toString()}', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Nova Senha'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Digite sua nova senha',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headLineMedium,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _senhaController,
                  decoration: const InputDecoration(labelText: 'Nova Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmarSenhaController,
                  decoration: const InputDecoration(labelText: 'Confirmar Nova Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _senhaController.text) {
                      return 'As senhas não coincidem.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: _handleResetPassword,
                    child: const Text('Salvar Nova Senha'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
