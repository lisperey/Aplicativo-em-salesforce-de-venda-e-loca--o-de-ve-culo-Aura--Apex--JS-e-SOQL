({   //Função para alocar os valores na tabela
    buscarRegistro : function(component, event, helper) {
        
        component.set('v.columns', [
            {label: 'Id', fieldName: 'Name', type: 'Id', editable: true},
            {label: 'Cliente', fieldName: 'ClienteName', type: 'text', editable: true},
            {label: 'Veículo', fieldName: 'Modelo', type: 'text', editable: true},
            {label: 'Marca', fieldName: 'Marca', type: 'text', editable: true},
            {label: 'Preço de Venda', fieldName: 'Preco_Venda__c', type: 'currency', editable: true},
            {label: 'Sede', fieldName: 'SedeName', type: 'text', editable: true},
            {label: 'Valor Total da Venda', fieldName: 'Valor_Total_Venda_Veiculo__c', type: 'currency', editable: true},
            
            
            
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