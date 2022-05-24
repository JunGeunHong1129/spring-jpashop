package jpabook.jpashop.service;

import jpabook.jpashop.domain.entity.Member;
import jpabook.jpashop.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MemberService {

    private final MemberRepository memberRepository;

    @Transactional()
    public Long join(Member member){
        validateDuplicateMember(member);
        memberRepository.save(member);
        return member.getId();
    }

    public List<Member> findAllMember(){
        return memberRepository.findAllMember();
    }

    public Member findMember(Long memberId){
        return memberRepository.findMemberById(memberId);
    }


    private void validateDuplicateMember(Member member) {
        //EXCEPTION
        List<Member> memberList = memberRepository.findMemberByName(member.getName());
        if(!memberList.isEmpty()){
            throw new IllegalStateException("이미 존재하는 회원입니다.");
        }
    }


}
