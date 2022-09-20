global with sharing class Invocar {
    
    public class idEntrada{
        
        @invocableVariable(label='id cliente')
        public Id recordId;  
        
    }
   
    @InvocableMethod(label='Pegar Sede')
    public static void atualizarTotalCliente(List<idEntrada> pegarId){
        
       List<Atividade__c> pegarSede = new List<Atividade__c>();
        
       for(idEntrada edf : pegarId){
            pegarSede.add([Select Total_de_clientes__c from Atividade__c where Id =: edf.recordId]);
            
        }
    
        
        for(Atividade__c sede: pegarSede ){
            sede.Total_de_clientes__c = (sede.Total_de_clientes__c - 1);
            
        }

        Update pegarSede;
            
        
        
        
        
    }

    
}