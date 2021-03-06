package it.solvingteam.auction.domain;

import javax.persistence.Entity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import it.solvingteam.auction.domain.Bid;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;

@Entity
@RooJavaBean
@RooToString
@RooEntity
public class Item {

    @NotNull
    @Size(min = 2)
    private String name;

    private String description;

    @NotNull
    private Float startingPrice;
}
