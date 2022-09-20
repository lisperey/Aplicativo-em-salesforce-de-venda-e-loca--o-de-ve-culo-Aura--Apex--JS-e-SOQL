({  //enviar para o apex as infromações que foram passadas
    enviarRegistro: function(component, event, helper) {

        var action = component.get('c.salvarNovoRegistro');
        

  

        action.setParams({
            modelo : component.get('v.modelo'),
            marca : component.get('v.marca'),
            estoqueVendas : component.get('v.estoqueVenda'),
            estoqueLocacao : component.get('v.estoqueLocacao'),
            nivel : component.get('v.nivel'),
            sede : component.get('v.sede'),
        })

        action.setCallback(this, function(response){
            let state = response.getState();
            var resposta = response.getReturnValue();

            

            if(state == 'SUCCESS'){

                helper.showToast("Successo!", "Registro criado com sucesso.", "success");
                helper.limparCampos(component, event, helper);
                helper. createRecord(resposta, event, helper);
                
                
            
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

        component.set('v.modelo', null);
        component.set('v.marca', null);
        component.set('v.estoqueVenda', null);
        component.set('v.estoqueLocacao', null);
        component.set('v.nivel', null);
        component.set('v.sede', null);

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