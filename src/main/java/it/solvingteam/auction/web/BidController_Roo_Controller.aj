package it.solvingteam.auction.web;

import it.solvingteam.auction.domain.Bid;
import it.solvingteam.auction.domain.Item;
import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect BidController_Roo_Controller {
    
    @RequestMapping(value = "/bid", method = RequestMethod.POST)
    public String BidController.create(@Valid Bid bid, BindingResult result, ModelMap modelMap) {
        if (bid == null) throw new IllegalArgumentException("A bid is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("bid", bid);
            modelMap.addAttribute("items", Item.findAllItems());
            return "bid/create";
        }
        bid.persist();
        return "redirect:/bid/" + bid.getId();
    }
    
    @RequestMapping(value = "/bid/form", method = RequestMethod.GET)
    public String BidController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("bid", new Bid());
        modelMap.addAttribute("items", Item.findAllItems());
        return "bid/create";
    }
    
    @RequestMapping(value = "/bid/{id}", method = RequestMethod.GET)
    public String BidController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("bid", Bid.findBid(id));
        return "bid/show";
    }
    
    @RequestMapping(value = "/bid", method = RequestMethod.GET)
    public String BidController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("bids", Bid.findBidEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Bid.countBids() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("bids", Bid.findAllBids());
        }
        return "bid/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String BidController.update(@Valid Bid bid, BindingResult result, ModelMap modelMap) {
        if (bid == null) throw new IllegalArgumentException("A bid is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("bid", bid);
            modelMap.addAttribute("items", Item.findAllItems());
            return "bid/update";
        }
        bid.merge();
        return "redirect:/bid/" + bid.getId();
    }
    
    @RequestMapping(value = "/bid/{id}/form", method = RequestMethod.GET)
    public String BidController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("bid", Bid.findBid(id));
        modelMap.addAttribute("items", Item.findAllItems());
        return "bid/update";
    }
    
    @RequestMapping(value = "/bid/{id}", method = RequestMethod.DELETE)
    public String BidController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        Bid.findBid(id).remove();
        return "redirect:/bid?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
}
