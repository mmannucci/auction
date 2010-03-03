package it.solvingteam.auction.domain;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Item_Roo_Configurable {
    
    declare @type: Item: @Configurable;
    
}
