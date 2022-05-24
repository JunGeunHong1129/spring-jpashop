package jpabook.jpashop.service;

import jpabook.jpashop.domain.entity.Member;
import jpabook.jpashop.repository.MemberRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class MemberServiceTest {

    @Autowired
    MemberService memberService;

    @Autowired
    MemberRepository memberRepository;

    @Test
    @DisplayName("회원 가입 테스트")
    void join() {
        // given
        Member member = new Member();
        member.setName("홍준근");

        // when
        Long joinedMemberId = memberService.join(member);

        // then
        assertEquals(member,memberRepository.findMemberById(joinedMemberId));


    }

    @Test
    @DisplayName("전체 회원 조회 테스트")
    void duplicateCheck() {
        // given
        Member member1 = new Member();
        member1.setName("홍준근");

        Member member2 = new Member();
        member2.setName("홍준근");

        // when
        memberService.join(member1);


        // then
        assertThrows(IllegalStateException.class,() -> {
            memberService.join(member2);
        });

    }

}