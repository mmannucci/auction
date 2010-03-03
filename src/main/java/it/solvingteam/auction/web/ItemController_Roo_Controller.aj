package it.solvingteam.auction.web;

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

privileged aspect ItemController_Roo_Controller {
    
    @RequestMapping(value = "/item", method = RequestMethod.POST)
    public String ItemController.create(@Valid Item item, BindingResult result, ModelMap modelMap) {
        if (item == null) throw new IllegalArgumentException("A item is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("item", item);
            return "item/create";
        }
        item.persist();
        return "redirect:/item/" + item.getId();
    }
    
    @RequestMapping(value = "/item/form", method = RequestMethod.GET)
    public String ItemController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("item", new Item());
        return "item/create";
    }
    
    @RequestMapping(value = "/item/{id}", method = RequestMethod.GET)
    public String ItemController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("item", Item.findItem(id));
        return "item/show";
    }
    
    @RequestMapping(value = "/item", method = RequestMethod.GET)
    public String ItemController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("items", Item.findItemEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Item.countItems() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("items", Item.findAllItems());
        }
        return "item/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String ItemController.update(@Valid Item item, BindingResult result, ModelMap modelMap) {
        if (item == null) throw new IllegalArgumentException("A item is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("item", item);
            return "item/update";
        }
        item.merge();
        return "redirect:/item/" + item.getId();
    }
    
    @RequestMapping(value = "/item/{id}/form", method = RequestMethod.GET)
    public String ItemController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("item", Item.findItem(id));
        return "item/update";
    }
    
    @RequestMapping(value = "/item/{id}", method = RequestMethod.DELETE)
    public String ItemController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        Item.findItem(id).remove();
        return "redirect:/item?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
}
