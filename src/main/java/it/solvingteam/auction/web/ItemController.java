package it.solvingteam.auction.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import it.solvingteam.auction.domain.Item;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "item", automaticallyMaintainView = true, formBackingObject = Item.class)
@RequestMapping("/item/**")
@Controller
public class ItemController {
}
