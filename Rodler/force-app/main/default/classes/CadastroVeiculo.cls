public with sharing class CadastroVeiculo {
   ///insertar veiculo
    @AuraEnabled
    public static Id salvarNovoRegistro(String modelo, String marca, String nivel, Integer estoqueVendas, Integer estoqueLocacao, Id sede){
        Atividade__c novoRegistro = new Atividade__c();
        
        Double precoVenda;
        Double precoLocacao;
        //condição para passar o valor da locação e venda do veiculo

        if(nivel== 'Premium'){
            precoLocacao= 150;
            precoVenda = 150000;
        }
        else if(nivel == 'Conforto'){
            precoLocacao = 100;
            precoVenda= 100000;

        }
        else if(nivel== 'Economia'){
            precoLocacao = 50;
            precoVenda = 50000;

        }

       
        
        Id id = '0124x000000ZyoRAAS'; 

        novoRegistro.RecordTypeId= id;
        novoRegistro.Preco_Locacao__c = precoLocacao;
        novoRegistro.Preco_Venda__c = precoVenda;
        novoRegistro.Modelo__c= modelo;
        novoRegistro.Marca__c = marca;
        novoRegistro.Nivel__c = nivel;
        novoRegistro.Sede__c = sede;
        novoRegistro.Estoque_Venda__c= estoqueVendas;
        novoRegistro.Estoque_Locacao__c= estoqueLocacao;
        novoRegistro.Quantidade_Dispon_vel_Para_Loca_o__c = estoqueLocacao;
        Insert novoRegistro;
        return novoRegistro.Id;

}
    


}