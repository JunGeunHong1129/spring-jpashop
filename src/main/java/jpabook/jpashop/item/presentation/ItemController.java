package jpabook.jpashop.item.presentation;


import jpabook.jpashop.item.dto.BookRegisterFormDTO;
import jpabook.jpashop.item.entity.Book;
import jpabook.jpashop.item.entity.Item;
import jpabook.jpashop.item.service.ItemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class ItemController {

    private final ItemService itemService;

    @GetMapping("/items")
    public String itemList(Model model){
        List<Item> itemList = itemService.findItemList();
        model.addAttribute("items",itemList);
        return "items/itemList";
    }


    @GetMapping("/items/new")
    public String createForm(Model model){

        model.addAttribute("itemForm", new BookRegisterFormDTO());

        return "items/createItemForm";
    }

    @PostMapping("/items/new")
    public String create(@Valid @ModelAttribute("itemForm") BookRegisterFormDTO form, BindingResult result){

        if(result.hasErrors()){
            return "items/createItemForm";
        }
        Book book = new Book();
        book.setName(form.getName());
        book.setPrice(form.getPrice());
        book.setStockQuantity(form.getStockQuantity());
        book.setAuthor(form.getAuthor());
        book.setIsbn(form.getIsbn());

        itemService.addItem(book);

        return "redirect:/";
    }


    @GetMapping("/items/{itemId}/edit")
    public String editForm(@PathVariable("itemId") Long itemId, Model model){

        Book item = (Book) itemService.findItemById(itemId);

        BookRegisterFormDTO itemForm = new BookRegisterFormDTO();

        itemForm.setId(item.getId());
        itemForm.setName(item.getName());
        itemForm.setPrice(item.getPrice());
        itemForm.setStockQuantity(item.getStockQuantity());
        itemForm.setAuthor(item.getAuthor());
        itemForm.setIsbn(item.getIsbn());

        model.addAttribute("itemForm", itemForm);

        return "items/updateItemForm";


    }

    @PostMapping("/items/{itemId}/edit")
    public String edit(@PathVariable Long itemId, @Valid @ModelAttribute("itemForm") BookRegisterFormDTO itemForm, BindingResult result , RedirectAttributes redirectAttributes){
        if(result.hasErrors()){
            return "items/updateItemForm";
        }
        Book book = new Book();
        book.setId(itemForm.getId());
        book.setName(itemForm.getName());
        book.setPrice(itemForm.getPrice());
        book.setStockQuantity(itemForm.getStockQuantity());
        book.setAuthor(itemForm.getAuthor());
        book.setIsbn(itemForm.getIsbn());

        itemService.addItem(book);

        return "redirect:/items";
    }


}
