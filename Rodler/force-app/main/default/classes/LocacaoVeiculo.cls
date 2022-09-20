public with sharing class LocacaoVeiculo {
   

    //verificando se o cleinte tem locação 
    @AuraEnabled
    public static Boolean pegarCliente(Id cliente){

        Id idRegistro = '0124x000000a08FAAQ';

        List<Atividade__c> valorCliente = [select Cliente__c from Atividade__c 
                                          where(Cliente__c =:cliente AND RecordTypeId=:idRegistro AND Status__c='Ativo')];

        Boolean eVazio = valorCliente.isEmpty();
        return eVazio;
    }
    
    //pegando informações do veiculo
    @AuraEnabled
    public static List<Atividade__c> pegarVeiculo(Id veiculo){

        List<Atividade__c> valorVeiculo = [select Preco_Locacao__c, Quantidade_Dispon_vel_Para_Loca_o__c, Modelo__c, Marca__c from Atividade__c 
                                               where(Id =:veiculo)];
       
        return valorVeiculo;
        
    }

    
   //calculando o desconto
    @AuraEnabled
    public static List<Double> calcDesconto(Id veiculo, Integer quantos_dias){
        //pegando o preço da locação
        Double precoLocacao = pegarVeiculo(veiculo)[0].Preco_Locacao__c;
        //fazendo o calculo do valor toal da locação
        Double valorLocacao = precoLocacao * quantos_dias;

        Double porcetagem;
        Integer descontoPorcentagem;

       //condição para aplicar  desconto
        if(quantos_dias >=21){
            porcetagem = valorLocacao * 0.15;
            descontoPorcentagem = 15;
            
        }
        else if(quantos_dias > 13 && quantos_dias <=20 ){

            porcetagem = valorLocacao  * 0.10;
            descontoPorcentagem = 10;
        }

        else if(quantos_dias > 6 && quantos_dias <=13){
            porcetagem = valorLocacao * 0.05;
            descontoPorcentagem = 5;

        }
        else if(quantos_dias < 6){

            porcetagem = valorLocacao * 0.0;
            descontoPorcentagem = 0;
        }


        Double valorLocacaoTotal = valorLocacao - porcetagem;
        
        //lista com os valor do desconto e aporcentagem do desconto
        List<Double> listaValores= new List<Double>();
        listaValores.add(valorLocacaoTotal); 
        listaValores.add(descontoPorcentagem);

        return listaValores;
        
    
        
    }
     //calculando a data de volução
    @AuraEnabled
    public static Date calcDataDevolucao(Integer quantos_dias){
        
        Date devolucaoData = Date.today() + quantos_dias;
        
        
        return devolucaoData;
        
    }


     // insertado a locação
    @AuraEnabled
    public static String insertLocacao(Id veiculo, Id cliente, Id sede, Integer quantos_dias){
        Atividade__c novoRegistro = new Atividade__c();
        
        Double quatidadeDisponivelLocacao = pegarVeiculo(veiculo)[0].Quantidade_Dispon_vel_Para_Loca_o__c;
        //erros 
        String errorLocacao = 'erro quantidade locacao';
        String errorCliente = 'erro cliente';
        String errorData = 'data';
        
        //variaveis para verificar se a data é no final de semana
        
        Date dataDevolucao = calcDataDevolucao(quantos_dias);
        Date colocarUmDia = dataDevolucao + 1;
        Date pegarDomingo = colocarUmDia.toStartofWeek();
        Date pegarSabado = pegarDomingo - 1;

        
        Id idRegistro = '0124x000000a08FAAQ';
        novoRegistro.RecordTypeId= idRegistro;
        novoRegistro.Desconto__c = calcDesconto(veiculo, quantos_dias)[1];
        novoRegistro.Data_de_Devolucao__c = dataDevolucao;
        novoRegistro.Preco_Locacao__c = pegarVeiculo(veiculo)[0].Preco_Locacao__c;
        novoRegistro.valor_total_da_locacao__c = calcDesconto(veiculo, quantos_dias)[0];
        novoRegistro.Cliente__c= cliente;
        novoRegistro.Veiculo__c = veiculo;
        novoRegistro.Modelo__c = pegarVeiculo(veiculo)[0].Modelo__c;
        novoRegistro.Marca__c = pegarVeiculo(veiculo)[0].Marca__c;
        novoRegistro.Sede__c = sede;
        novoRegistro.Quantos_dias__c = quantos_dias;
        novoRegistro.Status__c = 'Ativo';

        
       //condição para saber se o cliente tem locaçãoa tiva
       if(pegarCliente(cliente) == false){ 

        return errorCliente;

       } 
       //condição para verificar se a devolução cai no final de semana
       else if(dataDevolucao == pegarDomingo || dataDevolucao == pegarSabado){
        return errorData;
       }
       //condição para verificar se a o veiculo tem estoque para locação
       else if(quatidadeDisponivelLocacao==0){

        return errorLocacao;
       }
       else{
        
        Insert novoRegistro;
        attQtdDisponivelVeic(veiculo);
        totalGastoLocacoes(cliente);
        return novoRegistro.Id;
       }

       


    }
    //atualizando a quantidade disponível para locação
    @AuraEnabled
    public static Void attQtdDisponivelVeic(Id veiculo){
        

        List<Atividade__c> valorVeiculo = [select Quantidade_Dispon_vel_Para_Loca_o__c from Atividade__c where(Id =:veiculo)];
        Double QtdDisponivelVeic = valorVeiculo[0].Quantidade_Dispon_vel_Para_Loca_o__c;

        for(Atividade__c attTotalCliente: valorVeiculo){
            attTotalCliente.Quantidade_Dispon_vel_Para_Loca_o__c= QtdDisponivelVeic-1;
        }
        
        Update valorVeiculo; 

        
    }

//atualizando o valor total que o cleinte gastou em locação 
    @AuraEnabled
    public static Void totalGastoLocacoes(Id cliente){

        Id idRegistro = '0124x000000a08FAAQ';


        List<Atividade__c> listaCliente = [select Cliente__c, valor_total_da_locacao__c
                                            from Atividade__c where(Cliente__c =:cliente AND RecordTypeId=:idRegistro)];

        Double somar=0;
        for(Atividade__c i: listaCliente){
            somar += i.valor_total_da_locacao__c;    

        }

        List<Atividade__c> pegarCampoTotalGasto = [select Total_gasto_locacoes__c from Atividade__c where(Id=:cliente)];

        for(Atividade__c valorTotalLoc: pegarCampoTotalGasto){
            valorTotalLoc.Total_gasto_locacoes__c = somar;

        }
        
        Update pegarCampoTotalGasto;
        

    }




}
