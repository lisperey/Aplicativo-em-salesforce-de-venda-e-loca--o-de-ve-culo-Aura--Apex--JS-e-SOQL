({  //enviar para o apex as informações que foram passadas
    enviarRegistro: function(component, event, helper) {

        var action = component.get('c.salvarNovoRegistro');
        console.log(component.get('v.navService'))

        action.setParams({
            nomeSede: component.get('v.nomeSede'),
            endereco : component.get('v.endereco'),
            
           

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

        component.set('v.nomeSede', null);
        component.set('v.endereco', null);
        

    },

    //função para redirecionar
    createRecord : function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        
        navEvt.setParams({
          "recordId": component,
          "slideDevName": "related"
        });
        navEvt.fire();
    }

    
})
