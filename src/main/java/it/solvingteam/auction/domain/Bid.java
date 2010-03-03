package it.solvingteam.auction.domain;

import javax.persistence.Entity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import javax.validation.constraints.NotNull;
import it.solvingteam.auction.domain.Item;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;

@Entity
@RooJavaBean
@RooToString
@RooEntity
public class Bid {

    @NotNull
    private Float amount;

    @NotNull
    @ManyToOne(targetEntity = Item.class)
    @JoinColumn
    private Item item;
}
