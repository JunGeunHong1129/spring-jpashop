package jpabook.jpashop.order.presentation;


import jpabook.jpashop.order.command.domain.dto.OrderSearchDTO;
import jpabook.jpashop.item.entity.Item;
import jpabook.jpashop.member.entity.Member;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.item.service.ItemService;
import jpabook.jpashop.member.service.MemberService;
import jpabook.jpashop.order.command.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final MemberService memberService;
    private final ItemService itemService;

    @GetMapping("/order")
    public String createOrderForm(Model model) {

        List<Member> members = memberService.findAllMember();
        List<Item> items = itemService.findItemList();

        model.addAttribute("members", members);
        model.addAttribute("items", items);


        return "order/orderForm";
    }

    @PostMapping("/order")
    public String createOrder(
            @RequestParam("memberId") Long memberId,
            @RequestParam("itemId") Long itemId,
            @RequestParam("count") int count) {
        Long order = orderService.order(memberId, itemId, count);


        return "redirect:/";
    }

    @GetMapping("/orders")
    public String orderList(@ModelAttribute("orderSearchForm")OrderSearchDTO orderSearchForm,Model model){

        List<Order> orders = orderService.findOrderList(orderSearchForm);
        model.addAttribute("orders",orders);

        return "order/orderList";

    }

    @PostMapping("/orders/{orderId}/cancel")
    public String orderCancel(@PathVariable("orderId") Long orderId){

        orderService.cancelOrder(orderId);

        return "redirect:/orders";
    }

}
