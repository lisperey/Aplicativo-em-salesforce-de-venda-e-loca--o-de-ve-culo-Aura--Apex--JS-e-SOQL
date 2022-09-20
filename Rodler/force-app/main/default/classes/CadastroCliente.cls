public with sharing class CadastroCliente {

  //metodo para insertar o cliente
    @AuraEnabled
    public static Id salvarNovoRegistro(String nomeDoCliente, String telefone, String CPF, String email, String endereco, Id sede){

        Atividade__c novoRegistro = new Atividade__c();
        Id idRegistro = '0124x000000ZyoCAAS';
    
        novoRegistro.RecordTypeId = idRegistro;
        novoRegistro.Name= nomeDoCliente;
        novoRegistro.Telefone__c = telefone;
        novoRegistro.CPF__c = CPF;
        novoRegistro.E_mail__c = email;
        novoRegistro.Enderecoo__c= endereco;
        novoRegistro.Sede__c = sede;
        novoRegistro.Total_gasto_locacoes__c = 0;
        novoRegistro.Descont_o_Rodler__c = 0;
        
        Insert novoRegistro;
        quantidadeClientes(sede);
        return novoRegistro.Id;
          

    } 
   
    //metodo que atualiza o total de cliente na sede
    @AuraEnabled
    public static List<Atividade__c> quantidadeClientes(Id sede){

        Id tipoRegistro = '0124x000000ZyoCAAS';

        List<Atividade__c> listaSede = [Select Cliente__c from Atividade__c where(RecordTypeId =:tipoRegistro AND Sede__c=:sede)];
        Integer tamanhoSede = listaSede.size();


        List<Atividade__c> pegarTotalCliente = [Select Total_de_clientes__c from Atividade__c where(Id=:sede)];
        

        for(Atividade__c attTotalCliente: pegarTotalCliente){
            attTotalCliente.Total_de_clientes__c = tamanhoSede;
        }
        
        Update pegarTotalCliente;  

        return pegarTotalCliente;

    } 

    
}
