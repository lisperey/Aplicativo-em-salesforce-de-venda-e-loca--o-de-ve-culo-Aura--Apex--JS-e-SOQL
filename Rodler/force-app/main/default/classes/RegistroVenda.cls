public with sharing class RegistroVenda {
    //metodo para peagr os dados dos registros no banco de dados
    @AuraEnabled
    public static List<Atividade__c> pegarRegistro() {
 
       Id idRegistro = '0124x000000a08AAAQ'; 
 
        List<Atividade__c> pesquisar = [Select Name, Cliente__r.Name, Veiculo__r.Modelo__c, Veiculo__r.Marca__c, Preco_Venda__c, 
                                        Sede__r.Name, Valor_Total_Venda_Veiculo__c from 
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
