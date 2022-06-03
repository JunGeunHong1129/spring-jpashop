package jpabook.jpashop.web.controller;


import jpabook.jpashop.domain.dto.MemberRegisterFormDTO;
import jpabook.jpashop.domain.entity.Address;
import jpabook.jpashop.domain.entity.Member;
import jpabook.jpashop.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    /// 출력 또한 DTO를 뿌려야하는게 맞지만 단순한 예제라서 이렇게 진행되었다.
    @GetMapping("/members")
    public String memberList(Model model){
        List<Member> members = memberService.findAllMember();
        model.addAttribute("members",members);

        return "members/memberList";
    }

    @GetMapping(value = "/members/new")
    public String createForm( Model model){

        model.addAttribute("memberForm",new MemberRegisterFormDTO());

        return "members/createMemberForm";
    }

    @PostMapping(value = "/members/new")
    public String create(@Valid @ModelAttribute("memberForm") MemberRegisterFormDTO memberForm, BindingResult result){

        if(result.hasErrors()){
            return "members/createMemberForm";
        }

        Member member = new Member();
        member.setName(memberForm.getName());
        member.setAddress(new Address(memberForm.getCity(),memberForm.getStreet(),memberForm.getZipcode()));

        memberService.join(member);

        return "redirect:/";
    }




}
