global with sharing class Invocar2 {
    public class idEntrada{
        
        @invocableVariable(label='id ')
        public Id recordId;  
        
    }
   
    @InvocableMethod(label='pegar veiculo')
    public static void  atualizarTotalLocacao(List<idEntrada> pegarId){
        
       List<Atividade__c> quantidadeLoc = new List<Atividade__c>();
        
       for(idEntrada edf : pegarId){


        quantidadeLoc.add([Select Estoque_Locacao__c from Atividade__c where Id =: edf.recordId]);
            
        }

        for(Atividade__c att: quantidadeLoc){
            att.Estoque_Locacao__c = (att.Estoque_Locacao__c +1);
        }
    

        Update quantidadeLoc;
            
        
        
        
        
    }

    
}
