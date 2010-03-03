package it.solvingteam.auction.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import it.solvingteam.auction.domain.Bid;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "bid", automaticallyMaintainView = true, formBackingObject = Bid.class)
@RequestMapping("/bid/**")
@Controller
public class BidController {
}
