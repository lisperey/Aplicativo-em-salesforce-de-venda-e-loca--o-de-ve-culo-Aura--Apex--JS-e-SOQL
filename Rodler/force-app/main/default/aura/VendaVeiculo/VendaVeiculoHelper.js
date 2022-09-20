({  
    //enviando os dados da p=venda apra o apex
    enviarVenda: function(component, event, helper) {

        var action = component.get('c.insertarVenda');

        
        action.setParams({

            veiculo : component.get('v.veiculo'),
            cliente: component.get('v.cliente'),
            sede: component.get('v.sede'),
            quantidade: component.get('v.quantidade'),
            
            
        });

        action.setCallback(this, function(response){
            let resposta = response.getReturnValue();
            let state = response.getState();
            

            console.log(resposta);

            
           // condição apra verificar erro do back e se o estoque for vazio
            if(state == 'SUCCESS' && resposta != erroQuantidade){
                helper.showToast("Successo!", "Registro criado com sucesso.", "success");
                helper.limparCampos(component, event, helper);
                helper.createRecord(resposta, event, helper);
                  
            
            }else{

                helper.showToast("Error!", "Ocorreu um error!", "error");
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

        component.set('v.cliente', null);
        component.set('v.sede', null);
        component.set('v.quantos_dias', null);
        component.set('v.veiculo', null);

    },

    //abrir registro
    createRecord : function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        
        navEvt.setParams({
          "recordId": component,
          "slideDevName": "related"
        });
        navEvt.fire();
    }
})