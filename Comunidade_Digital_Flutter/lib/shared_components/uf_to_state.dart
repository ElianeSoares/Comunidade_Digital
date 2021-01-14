String ufToState(String uf){
  switch(uf){
    case "AC": return "ACRE"; break;
    case "AL": return "ALAGOAS"; break;
    case "AP": return "AMAPÁ"; break;
    case "AM": return "AMAZONAS"; break;
    case "BA": return "BAHIA"; break;
    case "CE": return "CEARÁ"; break;
    case "DF": return "DISTRITO FEDERAL"; break;
    case "ES": return "ESPÍRITO SANTO"; break;
    case "GO": return "GOIÁS"; break;
    case "MA": return "MARANHÃO"; break;
    case "MT": return "MATO GROSSO"; break;
    case "MS": return "MATO GROSSO DO SUL"; break;
    case "MG": return "MINAS GERAIS"; break;
    case "PA": return "PARÁ"; break;
    case "PB": return "PARAÍBA"; break;
    case "PR": return "PARANÁ"; break;
    case "PE": return "PERNAMBUCO"; break;
    case "PI": return "PIAUÍ"; break;
    case "RJ": return "RIO DE JANEIRO"; break;
    case "RN": return "RIO GRANDE DO NORTE"; break;
    case "RS": return "RIO GRANDE DO SUL"; break;
    case "RO": return "RONDÔNIA"; break;
    case "RR": return "RORAIMA"; break;
    case "SC": return "SANTA CATARINA"; break;
    case "SP": return "SÃO PAULO"; break;
    case "SE": return "SERGIPE"; break;
    case "TO": return "TOCANTINS"; break;
    default: return "ERROR"; break;
  }
}