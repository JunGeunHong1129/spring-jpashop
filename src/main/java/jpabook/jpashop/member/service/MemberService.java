package jpabook.jpashop.member.service;

import jpabook.jpashop.member.dto.UpdateMemberRequest;
import jpabook.jpashop.member.entity.Member;
import jpabook.jpashop.member.repository.MemberRepository;
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

    @Transactional()
    public void updateMember(Long memberId, UpdateMemberRequest member){
        Member findMember = memberRepository.findById(memberId).get();
        findMember.setName(member.getName());
    }

    public List<Member> findAllMember(){
        return memberRepository.findAll();
    }

    public Member findMember(Long memberId){
        return memberRepository.findById(memberId).get();
    }


    private void validateDuplicateMember(Member member) {
        //EXCEPTION
        List<Member> memberList = memberRepository.findByName(member.getName());
        if(!memberList.isEmpty()){
            throw new IllegalStateException("이미 존재하는 회원입니다.");
        }
    }


}
