package it.solvingteam.auction.domain;

import it.solvingteam.auction.domain.Bid;
import it.solvingteam.auction.domain.ItemDataOnDemand;
import java.security.SecureRandom;
import java.util.List;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

privileged aspect BidDataOnDemand_Roo_DataOnDemand {
    
    declare @type: BidDataOnDemand: @Component;
    
    private Random BidDataOnDemand.rnd = new SecureRandom();
    
    private List<Bid> BidDataOnDemand.data;
    
    @Autowired
    private ItemDataOnDemand BidDataOnDemand.itemDataOnDemand;
    
    public Bid BidDataOnDemand.getNewTransientBid(int index) {
        it.solvingteam.auction.domain.Bid obj = new it.solvingteam.auction.domain.Bid();
        obj.setAmount(new Integer(index).floatValue());
        obj.setItem(itemDataOnDemand.getRandomItem());
        return obj;
    }
    
    public Bid BidDataOnDemand.getSpecificBid(int index) {
        init();
        if (index < 0) index = 0;
        if (index > (data.size()-1)) index = data.size() - 1;
        Bid obj = data.get(index);
        return Bid.findBid(obj.getId());
    }
    
    public Bid BidDataOnDemand.getRandomBid() {
        init();
        Bid obj = data.get(rnd.nextInt(data.size()));
        return Bid.findBid(obj.getId());
    }
    
    public boolean BidDataOnDemand.modifyBid(Bid obj) {
        return false;
    }
    
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void BidDataOnDemand.init() {
        if (data != null) {
            return;
        }
        
        data = it.solvingteam.auction.domain.Bid.findBidEntries(0, 10);
        if (data == null) throw new IllegalStateException("Find entries implementation for 'Bid' illegally returned null");
        if (data.size() > 0) {
            return;
        }
        
        data = new java.util.ArrayList<it.solvingteam.auction.domain.Bid>();
        for (int i = 0; i < 10; i++) {
            it.solvingteam.auction.domain.Bid obj = getNewTransientBid(i);
            obj.persist();
            data.add(obj);
        }
    }
    
}
