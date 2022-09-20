public with sharing class RegistroVeiculo {
     //metodo para peagr os dados dos registros no banco de dados
     @AuraEnabled
     public static List<Atividade__c> pegarRegistro() {

        Id idRegistro = '0124x000000ZyoRAAS';
 
         List<Atividade__c> pesquisar = [Select Name, Marca__c, Modelo__c, Nivel__c, Preco_Venda__c, 
                                            Preco_Locacao__c, Estoque_Locacao__c, Estoque_Venda__c, Quantidade_Dispon_vel_Para_Loca_o__c,
                                            Sede__r.Name from 
                                            Atividade__c where(RecordTypeId=:idRegistro)];
         return pesquisar;
         
 
     }


    //metodo para atualizar os dados no banco de dados
     @AuraEnabled
     public static List<Atividade__c> atualizarRegistro(List<Atividade__c> registro){
         Update registro;
         return registro;
     }

     //metodo para pegar excluir os dados
    @AuraEnabled
    public static void deleteEmCadeia(List<Atividade__c> idLista){
        List<Atividade__c> deletar = [Select Id From Atividade__c Where Id in:idLista];
        delete deletar;
    }
}
