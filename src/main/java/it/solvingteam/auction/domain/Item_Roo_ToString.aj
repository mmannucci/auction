package it.solvingteam.auction.domain;

import java.lang.String;

privileged aspect Item_Roo_ToString {
    
    public String Item.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getName());
	return sb.toString();
    }
    
}
