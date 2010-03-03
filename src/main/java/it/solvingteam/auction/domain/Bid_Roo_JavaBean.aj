package it.solvingteam.auction.domain;

import it.solvingteam.auction.domain.Item;
import java.lang.Float;

privileged aspect Bid_Roo_JavaBean {
    
    public Float Bid.getAmount() {
        return this.amount;
    }
    
    public void Bid.setAmount(Float amount) {
        this.amount = amount;
    }
    
    public Item Bid.getItem() {
        return this.item;
    }
    
    public void Bid.setItem(Item item) {
        this.item = item;
    }
    
}
