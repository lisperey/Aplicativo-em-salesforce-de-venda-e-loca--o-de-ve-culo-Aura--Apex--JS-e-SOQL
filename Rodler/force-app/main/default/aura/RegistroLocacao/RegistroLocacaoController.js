({   //Função para alocar os valores na tabela
    buscarRegistro : function(component, event, helper) {

        component.set('v.columns', [
            {label: 'Id', fieldName: 'Name', type: 'text', editable: true},
            {label: 'Cliente', fieldName: 'Cliente', type: 'text', editable: true},
            {label: 'Modelo', fieldName: 'Modelo__c', type: 'text', editable: true},
            {label: 'Marca', fieldName: 'Marca__c', type: 'text', editable: true},
            {label: 'Preço da Locação', fieldName: 'Preco_locacao', type: 'currency', editable: true},
            {label: 'Data de Devolução', fieldName: 'Data_de_Devolucao__c', type: 'date', editable: true},
            {label: 'Desconto', fieldName: 'Desconto__c', type: 'percent-fixed', editable: true},
            {label: 'Status', fieldName: 'Status__c', type: 'text', editable: true},
            {label: 'Sede', fieldName: 'Sede', type: 'text', editable: true},
            {label: 'Valor Total da Locação', fieldName: 'valor_total_da_locacao__c', type: 'currency', editable: true},
             
            
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