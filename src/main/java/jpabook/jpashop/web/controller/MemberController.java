package jpabook.jpashop.web.controller;


import jpabook.jpashop.domain.dto.RegisterFormDTO;
import jpabook.jpashop.domain.entity.Address;
import jpabook.jpashop.domain.entity.Member;
import jpabook.jpashop.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @GetMapping(value = "/members/new")
    public String createForm( Model model){

        model.addAttribute("memberForm",new RegisterFormDTO());

        return "members/createMemberForm";
    }

    @PostMapping(value = "/members/new")
    public String create(@Valid RegisterFormDTO form, BindingResult result){

        if(result.hasErrors()){
            return "members/createMemberForm";
        }

        Member member = new Member();
        member.setName(form.getName());
        member.setAddress(new Address(form.getCity(),form.getStreet(),form.getZipcode()));

        memberService.join(member);

        return "redirect:/";
    }



}
