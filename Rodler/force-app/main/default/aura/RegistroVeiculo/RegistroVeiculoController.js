({   //Função para alocar os valores na tabela
    buscarRegistro : function(component, event, helper) {

        component.set('v.columns', [
            {label: 'Id', fieldName: 'Name', type: 'text', editable: true},
            {label: 'Modelo', fieldName: 'Modelo__c', type: 'text', editable: true},
            {label: 'Marca', fieldName: 'Marca__c', type: 'text', editable: true},
            {label: 'Nível', fieldName: 'Nivel__c', type: 'text', editable: true},
            {label: 'Preço Venda', fieldName: 'Preco_Venda__c', type: 'currency', editable: true},
            {label: 'Preço Locação', fieldName: 'Preco_Locacao__c', type: 'currency', editable: true},
            {label: 'Estoque Venda', fieldName: 'Estoque_Venda__c', type: 'numer', editable: true},
            {label: 'Estoque Locação', fieldName: 'Estoque_Locacao__c', type: 'number', editable: true},
            {label: 'Sede', fieldName: 'Sede', type: 'text', editable: true},
            {label: 'Quantidade Disponível Para Locação', fieldName: 'Quantidade_Dispon_vel_Para_Loca_o__c', type: 'number', editable: true},
            
            
            
        ]);

        helper.retornarInformação(component, event, helper);  

    },

    //Função para selecionar os registros 
    marcarRegistro: function(component, event, helper){

        var marcador = event.getParam('selectedRows');
        component.set("v.registros", marcador);

    },

   //Função que é ativada depois do click, envia para o helper a ação
    enviar: function(component, event, helper){
        helper.deletarRegistro(component, event, helper);  
    },

    //função do botão para enviar a informação de salvar a atualização
    salvarAtualizacao: function(component, event, helper){
        
        helper.atualizacao(component, event, helper);
    }

})