public class GuidedCPQController {
	private final SObject cart;
    
    public String getName() {
        if (cart != null)
            return (String)cart.get('Name');
        else 
            return '';
    }
    
    public String getStatus() {
        if (cart != null) 
            if (cart.getSObjectType().getDescribe().getName() == 'Opportunity')
            	return (String)cart.get('StageName');
        	else
                return (String)cart.get('Status');
        else 
            return '';
    }
    
    public GuidedCPQController() {
        Id cartId = ApexPages.currentPage().getParameters().get('id');
        if (cartId != null) {
            String cartObjName = cartId.getSobjectType().getDescribe().getName();
            String query;
            if (cartObjName == 'Opportunity') {
                query = 'SELECT Id, Name, StageName FROM Opportunity WHERE Id=:cartId';
            } else if (cartObjName == 'Quote') {
                query = 'SELECT Id, Name, Status FROM Quote WHERE Id=:cartId';
            } else if (cartObjName == 'Order') {
                query = 'SELECT Id, Name, Status FROM Order WHERE Id=:cartId';
            }
            
            cart = Database.query(query);
        }
    }

    public PageReference viewRecord() {
        //PageReference pg = new PageReference(cart);
        PageReference pg = new ApexPages.StandardController(cart).view();
        return pg.setRedirect(true);
    }
}