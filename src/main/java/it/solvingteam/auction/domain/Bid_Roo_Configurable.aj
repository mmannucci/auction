package it.solvingteam.auction.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Bid_Roo_Configurable {
    
    declare @type: Bid: @Configurable;
    
}
