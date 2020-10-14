({
    init: function(component, event, helper) {
        var sect = component.find("modalSection");
        switch(component.get("v.modalSize")) {
            case "small":
                $A.util.addClass(sect, "slds-modal_small");
                break;
            case "medium":
                $A.util.addClass(sect, "slds-modal_medium");
                break;
            case "large":
                $A.util.addClass(sect, "slds-modal_large");
                break;
        }
        
        var flow = component.find("myFlow");
        flow.startFlow(component.get("v.flowName"), component.get("v.params"));
    },
    
    statusChange: function(component, event, helper) {
        if (event.getParam('status') === "FINISHED") {
            var changeEvt = $A.get("e.c:FlowModalEvent");
            changeEvt.setParams({ 
                "status": "FINISHED",
                "name": component.get("v.flowName"),
                "params": component.get("v.params"),
                "tag": component.get("v.tag")
            });
            changeEvt.fire();

			$A.enqueueAction(component.get('c.hide'));

        }
    },
    
    hide: function(component, event, helper) {
//        component.set("v.showModal", false);
        component.destroy();
    },

})