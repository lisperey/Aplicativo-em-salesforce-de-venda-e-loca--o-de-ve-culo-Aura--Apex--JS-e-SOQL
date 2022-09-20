({  //enviar para o banco de dados as infromações que foram passadas
    enviarRegistro: function(component, event, helper) {

        var action = component.get('c.salvarNovoRegistro');

        action.setParams({
            nomeDoCliente : component.get('v.nomeDoCliente'),
            telefone : component.get('v.telefone'),
            CPF : component.get('v.CPF'),
            email : component.get('v.email'),
            endereco: component.get('v.endereco'),
            sede: component.get('v.sede')

           

        })

        action.setCallback(this, function(response){
            var state = response.getState();
            var resposta = response.getReturnValue();

            
            
            if(state == 'SUCCESS'){

                helper.showToast("Successo!", "Registro criado com sucesso.", "success");
                helper.limparCampos(component, event, helper);
                helper.createRecord(resposta, event, helper);
                
            
            }else{
                helper.showToast("Error!", "Ocorreu um error.", "error");
                helper.limparCampos(component, event, helper);
                
            
            }
                

        });


        $A.enqueueAction(action);


    },
  // função para mostrar mensagem 
    showToast : function(title, message, type) {

        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type": type

       
    });
        toastEvent.fire();
},


   //função para limpar os campos
    limparCampos : function(component, event, helper){

        component.set('v.nomeDoCliente', null);
        component.set('v.telefone', null);
        component.set('v.CPF', null);
        component.set('v.email', null);
        component.set('v.endereco', null);
        

    },
    createRecord : function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        
        navEvt.setParams({
          "recordId": component,
          "slideDevName": "related"
        });
        navEvt.fire();
    }

    
})
