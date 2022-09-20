public with sharing class CadastroSede {
    @AuraEnabled
    public static Id salvarNovoRegistro(String nomeSede, String endereco){

        Atividade__c novoRegistro = new Atividade__c();
        String idRegistro = '0124x000000a080AAA';

    
        novoRegistro.RecordTypeId = idRegistro;
        novoRegistro.Name= nomeSede;
        novoRegistro.Enderecoo__c= endereco;
        novoRegistro.
        
           
        Insert novoRegistro;
        return novoRegistro.Id;

        

    }

   
}


