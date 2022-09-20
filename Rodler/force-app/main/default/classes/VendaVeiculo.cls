public with sharing class VendaVeiculo {
   
  ///metodo para pegar o preço da venda e o estoque de venda do veiculo
    @AuraEnabled
    public static List<Atividade__c> pegarListaVeiculo(Id veiculo, Integer quantidade){
        
        List<Atividade__c> pegarVeiculo = [select Preco_Venda__c, Estoque_Venda__c from Atividade__c 
                                                  where(Id=:veiculo)];

        for(Atividade__c att: pegarVeiculo){

            att.Estoque_Venda__c = att.Estoque_Venda__c-quantidade;
                                                }
        
        return pegarVeiculo;

    }

    //// calcular o descontão e atualizar a quantidade de vezes que o descontão foi usado 
    @AuraEnabled
    public static Double descontao(Id cliente, id veiculo, Integer quantidade){
       
        List<Atividade__c> precoVenda = [select Preco_Venda__c from Atividade__c where(Id=:veiculo)];
        Double porcetagem =0.20 * precoVenda[0].Preco_Venda__c;
        
        List<Atividade__c> pegarCliente = [select Total_gasto_locacoes__c, Descont_o_Rodler__c from Atividade__c 
                                        where(Id=:cliente)];


        Double totalx = pegarCliente[0].Total_gasto_locacoes__c;
        Double desconto = 0;
        Double totalGasto = 0;

        // condição para ver quanto vai ser o descontão 
        if(porcetagem >= totalx){
            desconto = totalx;
               
        }
        else{
            desconto = porcetagem;
            totalGasto = totalx;    
        }

       //atualzando o total de descontao e o total gasto do cleinte em locações
        for(Atividade__c pegarDescontao: pegarCliente){
            pegarDescontao.Descont_o_Rodler__c = pegarDescontao.Descont_o_Rodler__c+1;
            pegarDescontao.Total_gasto_locacoes__c = totalGasto;
        }

       if(pegarCliente[0].Total_gasto_locacoes__c !=0){
        Update pegarCliente;

       }
       else{

       }
        return desconto;

    }

    
//metodo para insertar a venda
    @AuraEnabled
    public static String insertarVenda(Id veiculo, Id cliente, Id sede, Integer quantidade){
        Atividade__c novoRegistro = new Atividade__c();
        //pegando preço de venda do veiculo
        Double precoVeiculo = pegarListaVeiculo(veiculo, quantidade)[0].Preco_Venda__c;
        //valor total
        Double valorTotal = precoVeiculo*quantidade;
        //pegar  o estoque de vdo veiculo
        Double estoque = pegarListaVeiculo(veiculo, quantidade)[0].Estoque_Venda__c;
        String erroQuantidade = 'erro quantidade';
        
        
       Id idRegistro = '0124x000000a08AAAQ';
       //condição para ver a quantidade
        if(quantidade == 1){
            //adicionando descontão se o fori 1 veiculo
            novoRegistro.Valor_Total_Venda_Veiculo__c= valorTotal-descontao(cliente, veiculo, quantidade);

        }
        else{
            novoRegistro.Valor_Total_Venda_Veiculo__c= valorTotal;
        }

        novoRegistro.RecordTypeId= idRegistro;
        novoRegistro.Cliente__c= cliente;
        novoRegistro.Veiculo__c = veiculo;
        novoRegistro.Sede__c = sede;
        novoRegistro.Quantidade_de_V_Venda__c=quantidade;
        novoRegistro.Preco_Venda__c = precoVeiculo;

       
        if((estoque - quantidade) <=0){
            return erroQuantidade;
        }
        else{
           
            Insert novoRegistro; 
            //diminuir um no total da venda
            Update pegarListaVeiculo(veiculo, quantidade);
            return novoRegistro.Id;

        }
        

    }

    

}
    
