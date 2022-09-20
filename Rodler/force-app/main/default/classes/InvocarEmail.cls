global with sharing class InvocarEmail {
    public class idEntrada{
        
        @invocableVariable(label='id ')
        public Id recordId;  
        
    }
   
    @InvocableMethod(label='EnvioEmail')
    public static List<Atividade__c> atualizarTotalCliente(List<idEntrada> pegarId){
        
       List<Atividade__c> pegarRegistro = new List<Atividade__c>();
        
       for(idEntrada edf : pegarId){


        pegarRegistro.add([Select Cliente__c, valor_total_da_locacao__c from Atividade__c where Id =:edf.recordId]);
            
        }


        List<Atividade__c> passarInfo = new List<Atividade__c>();

        Double valorLoc = 0;
        Id cliente;

        for(Atividade__c vrf: pegarRegistro){
            valorLoc = vrf.valor_total_da_locacao__c;
            cliente = vrf.Cliente__c;
  
        }

        Double totaldasLoc = [Select Total_gasto_locacoes__c from Atividade__c where Id =:cliente].Total_gasto_locacoes__c;

        if((valorLoc*0.20)<=totaldasLoc){

            return pegarRegistro;
        }

        else {
            return null;
        }
        
        
        
    }




}
