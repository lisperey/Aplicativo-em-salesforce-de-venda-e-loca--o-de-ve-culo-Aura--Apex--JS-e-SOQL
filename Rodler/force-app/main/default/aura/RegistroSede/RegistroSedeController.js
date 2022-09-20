({   //Função para alocar os valores na tabela
    buscarRegistro : function(component, event, helper) {

        component.set('v.columns', [
            {label: 'Sede', fieldName: 'Name', type: 'text', editable: true},
            {label: 'Endereço', fieldName: 'Enderecoo__c', type: 'text', editable: true},
            {label: 'Total de Cliente', fieldName: 'Total_de_clientes__c', type: 'text', editable: true}
            
            
            
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