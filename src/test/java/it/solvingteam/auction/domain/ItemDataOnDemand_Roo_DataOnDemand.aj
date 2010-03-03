package it.solvingteam.auction.domain;

import it.solvingteam.auction.domain.Item;
import java.security.SecureRandom;
import java.util.List;
import java.util.Random;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

privileged aspect ItemDataOnDemand_Roo_DataOnDemand {
    
    declare @type: ItemDataOnDemand: @Component;
    
    private Random ItemDataOnDemand.rnd = new SecureRandom();
    
    private List<Item> ItemDataOnDemand.data;
    
    public Item ItemDataOnDemand.getNewTransientItem(int index) {
        it.solvingteam.auction.domain.Item obj = new it.solvingteam.auction.domain.Item();
        obj.setDescription("description_" + index);
        obj.setName("name_" + index);
        obj.setStartingPrice(new Integer(index).floatValue());
        return obj;
    }
    
    public Item ItemDataOnDemand.getSpecificItem(int index) {
        init();
        if (index < 0) index = 0;
        if (index > (data.size()-1)) index = data.size() - 1;
        Item obj = data.get(index);
        return Item.findItem(obj.getId());
    }
    
    public Item ItemDataOnDemand.getRandomItem() {
        init();
        Item obj = data.get(rnd.nextInt(data.size()));
        return Item.findItem(obj.getId());
    }
    
    public boolean ItemDataOnDemand.modifyItem(Item obj) {
        return false;
    }
    
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void ItemDataOnDemand.init() {
        if (data != null) {
            return;
        }
        
        data = it.solvingteam.auction.domain.Item.findItemEntries(0, 10);
        if (data == null) throw new IllegalStateException("Find entries implementation for 'Item' illegally returned null");
        if (data.size() > 0) {
            return;
        }
        
        data = new java.util.ArrayList<it.solvingteam.auction.domain.Item>();
        for (int i = 0; i < 10; i++) {
            it.solvingteam.auction.domain.Item obj = getNewTransientItem(i);
            obj.persist();
            data.add(obj);
        }
    }
    
}
