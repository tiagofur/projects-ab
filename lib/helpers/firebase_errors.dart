String getErrorString(String code){
  switch (code) {
    case 'ERROR_WEAK_PASSWORD':
      return 'Su contraseña es debil.';
    case 'ERROR_INVALID_EMAIL':
      return 'Su e-mail no es valido.';
    case 'ERROR_EMAIL_ALREADY_IN_USE':
      return 'E-mail ya es utilizado en otra cuenta.';
    case 'user-not-found':
      return 'Su e-mail no es valido.';
    case 'wrong-password':
      return 'Su contraseña es incorrecta.';
    case 'ERROR_USER_NOT_FOUND':
      return 'No hay usuario registrado con este e-mail.';
    case 'ERROR_USER_DISABLED':
      return 'El usuario esta desabilitado.';
    case 'ERROR_TOO_MANY_REQUESTS':
      return 'Muchas solicitudes. Intente nuevamente mas tarde.';
    case 'ERROR_OPERATION_NOT_ALLOWED':
      return 'Operacion no permitida.';

    default:
      return 'Ocurio un erro indefinido.';
  }
}