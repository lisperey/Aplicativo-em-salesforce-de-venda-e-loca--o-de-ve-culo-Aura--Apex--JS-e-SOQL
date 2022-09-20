({  //função para enviar os dados para o apex
    enviarLoc: function(component, event, helper) {

        var action = component.get('c.insertLocacao');
        
        
        action.setParams({

            veiculo : component.get('v.veiculo'),
            cliente: component.get('v.cliente'),
            sede: component.get('v.sede'),
            quantos_dias: component.get('v.quantos_dias')

            
        })

        action.setCallback(this, function(response){
            
            let resposta = response.getReturnValue();
            let errorLocacao = 'erro quantidade locacao';
            let errorCliente = 'erro cliente';
            let errorData = 'data';

            console.log(resposta);

        
            //condição para verificar erros
            if(resposta == errorCliente){

                helper.showToast("Error!", "Ocorreu um error. \nCliente não pode ter mais de uma locação!", "error");
                helper.limparCampos(component, event, helper);
                
                
            
            } else if(resposta == errorLocacao){
                helper.showToast("Error!", "Ocorreu um error. \nVeículo está indisponível!", "error");
                helper.limparCampos(component, event, helper);

            }
            else if(resposta == errorData){
                helper.showToast("Error!", "Ocorreu um error. \nA data de devolução não pode ser no final de semana!", "error");
                helper.limparCampos(component, event, helper);

            }
            else if(resposta == null){
                helper.showToast("Error!", "Ocorreu um error. \nA data de devolução não pode ser no final de semana!", "error");
                helper.limparCampos(component, event, helper);

            }
            else{
                helper.showToast("Successo!", "Registro criado com sucesso.", "success");
                helper.limparCampos(component, event, helper);
                helper.createRecord(resposta, event, helper);
                
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

        component.set('v.cliente', null);
        component.set('v.sede', null);
        component.set('v.quantos_dias', null);
        component.set('v.veiculo', null);

    },

   //pegar o registro
    createRecord : function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        
        navEvt.setParams({
          "recordId": component,
          "slideDevName": "related"
        });
        navEvt.fire();
    }
})