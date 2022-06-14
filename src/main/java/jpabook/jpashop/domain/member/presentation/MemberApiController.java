package jpabook.jpashop.domain.member.presentation;

import jpabook.jpashop.common.dto.Result;
import jpabook.jpashop.domain.member.dto.*;
import jpabook.jpashop.domain.member.entity.Member;
import jpabook.jpashop.domain.member.service.MemberService;

import lombok.RequiredArgsConstructor;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
public class MemberApiController {

    private final MemberService memberService;

    @GetMapping("/api/v1/members")
    public List<Member> membersV1(){
        return memberService.findAllMember();
    }

    @GetMapping("/api/v2/members")
    public Result membersV2(){

        List<Member> memberList = memberService.findAllMember();

        List<ReturnMemberDTO> list = memberList.stream().map(m -> new ReturnMemberDTO(m.getName())).collect(Collectors.toList());

        return new Result<>(list);
    }

    // 엔티티를 그대로 bean validation 적용한 버전
    // -> 프레젠테이션 계층에 엔티티를 사용하면 절대 안된다.
    // -> 회원 가입의 경우 SSO, oauth2등등 프레젠테이션에서 전달되는 데이터 스펙이 가지각색이기 때문
    @PostMapping("/api/v1/members")
    public CreateMemberResponse saveMemberV1(@RequestBody @Valid Member member){
        Long id = memberService.join(member);
        return new CreateMemberResponse(id);
    }

    // ExceptionHandler는 말그대로 예외를 컨트롤 하기 위한 것이다.
    // JSON 형식 자체가 박살나서 넘어오는 경우가 대표적이다.
    // ExceptionHandler는 이런식으로 넘겨주는게 일반적이며 나머지의 경우에는
    // RuntimeException에 defaultMessage를 담아서 넘기는게 일반적이다.
    // 다음과 같은 순서로 검사 한다.
    // 1) 예외처리 (글로벌 예외까지)
    // 2) 인풋 데이터 유효성 검사
    @PostMapping("/api/v2/members")
    public CreateMemberResponse saveMemberV2(@RequestBody @Valid CreateMemberRequest memberRequest, BindingResult bindingResult){

        if(bindingResult.hasErrors()){
            List<ObjectError> errors = bindingResult.getAllErrors();
            throw new RuntimeException(errors.get(0).getDefaultMessage());
        }

        Member member = new Member();
        member.setName(memberRequest.getName());

        Long id = memberService.join(member);
        return new CreateMemberResponse(id);
    }

    @PutMapping("/api/v2/members/{id}")
    public UpdateMemberResponse editMemberV1(@PathVariable("id") Long id, @RequestBody @Valid UpdateMemberRequest memberRequest, BindingResult bindingResult){

        memberService.updateMember(id,memberRequest);

        Member member = memberService.findMember(id);

        return new UpdateMemberResponse(member.getId(),member.getName());
    }






}
