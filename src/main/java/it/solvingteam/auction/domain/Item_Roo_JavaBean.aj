package it.solvingteam.auction.domain;

import java.lang.Float;
import java.lang.String;

privileged aspect Item_Roo_JavaBean {
    
    public String Item.getName() {
        return this.name;
    }
    
    public void Item.setName(String name) {
        this.name = name;
    }
    
    public String Item.getDescription() {
        return this.description;
    }
    
    public void Item.setDescription(String description) {
        this.description = description;
    }
    
    public Float Item.getStartingPrice() {
        return this.startingPrice;
    }
    
    public void Item.setStartingPrice(Float startingPrice) {
        this.startingPrice = startingPrice;
    }
    
}
