validarCPF(cpf) {
  var Soma;
  var Resto;
  if(cpf.length != 14) return false;
  Soma = 0;
  cpf = cpf.replaceAll("-", "");
  cpf = cpf.replaceAll(".", "");

  for (var i=1; i<=9; i++) Soma = Soma + int.tryParse(cpf.substring(i-1, i)) * (11 - i);
  Resto = (Soma * 10) % 11;

  if ((Resto == 10) || (Resto == 11))  Resto = 0;
  if (Resto != int.tryParse(cpf.substring(9, 10)) ) return false;

  Soma = 0;
  for (var i = 1; i <= 10; i++) Soma = Soma + int.tryParse(cpf.substring(i-1, i)) * (12 - i);
  Resto = (Soma * 10) % 11;

  if ((Resto == 10) || (Resto == 11))  Resto = 0;
  if (Resto != int.tryParse(cpf.substring(10, 11) ) ) return false;
  return true;
}