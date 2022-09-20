({
    //Função para pegar os dados do banco de dados
    retornarInformação: function(component, event, helper) {
        var action = component.get('c.pegarRegistro');

        action.setCallback(this, function(response){
            let resposta = response.getReturnValue();
            console.log(resposta)
            component.set('v.contas', resposta);    

        });

        $A.enqueueAction(action);


    },

    //Função que enviar para o apex a ordem para deletar
    deletarRegistro: function(component, event, helper) {
        var action = component.get('c.deleteEmCadeia');
        var ondeDeletar = component.get('v.registros');
        console.log(ondeDeletar)
        
        //Condição para confirmar a exclução do registro
        if(confirm("Deseja deletar?") == true){
            
            action.setParams({idLista: ondeDeletar});

        }

      
        action.setCallback(this, function(response){
            let state = response.getState();
                            
            if(state == 'SUCCESS'){
                $A.get('e.force:refreshView').fire();  
                helper.showToast("Successo!", "Registro atualizado com sucesso.", "success");
                
                }
            });
        
        $A.enqueueAction(action);
            
    },


    //função que envia as informações de atualização do registro para o apex
    atualizacao: function(component, event, helper){
        var action = component.get('c.atualizarRegistro');
        var draftValores = event.getParam('draftValues');

        action.setParams({
            registro : draftValores   
        });
        
        action.setCallback(this, function(response){
            let state = response.getState()
            let resposta = response.getReturnValue();

            
            console.log(resposta);

            if(state == "SUCCESS"){
                
                helper.showToast("Successo!", "Registro atualizado com sucesso.", "success");

            }
             
        });
        $A.enqueueAction(action);
    },


    //Função para mostrar mensagem de confirmação 
    showToast : function(title, message, type) {

        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type": type

        });
        toastEvent.fire();
    }
    
    
    

    

})