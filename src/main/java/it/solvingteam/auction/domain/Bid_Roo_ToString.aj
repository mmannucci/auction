package it.solvingteam.auction.domain;

import java.lang.String;

privileged aspect Bid_Roo_ToString {
    
    public String Bid.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("Amount: ").append(getAmount()).append(", ");
        sb.append("Item: ").append(getItem());
        return sb.toString();
    }
    
}
