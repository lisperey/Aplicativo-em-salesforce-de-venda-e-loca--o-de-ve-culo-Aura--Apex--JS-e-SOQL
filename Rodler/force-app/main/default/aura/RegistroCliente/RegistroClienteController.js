({   //Função para alocar os valores na tabela
    buscarRegistro : function(component, event, helper) {

        component.set('v.columns', [
            {label: 'Nome do CLiente', fieldName: 'Name', type: 'text', editable: true},
            {label: 'CPF', fieldName: 'CPF__c', type: 'text', editable: true},
            {label: 'E_mail', fieldName: 'E_mail__c', type: 'email', editable: true},
            {label: 'Telefone', fieldName: 'Telefone__c', type: 'Phone', editable: true},
            {label: 'Endereço', fieldName: 'Enderecoo__c', type: 'text', editable: true},
            {label: 'Sede', fieldName: 'Sede', type: 'Text', editable: true},
            {label: 'Vezes que usou Descontão ', fieldName: 'Descont_o_Rodler__c', type: 'number', editable: true},
            {label: 'Total gasto em Locações', fieldName: 'Total_gasto_locacoes__c', type: 'currency', editable: true},

            
            
        ]);

        helper.retornarInformação(component, event, helper);  

    },

    //Função para selecionar os registros 
    marcarRegistro: function(component, event, helper){

        var marcador = event.getParam('selectedRows');
        component.set("v.registroClient", marcador);

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