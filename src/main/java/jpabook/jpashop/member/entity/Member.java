package jpabook.jpashop.member.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.order.command.domain.entity.Order;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
public class Member {

    @Id
    @GeneratedValue
    @Column(name = "member_id")
    private Long id;

    private String name;

    @Embedded
    private Address address;

    @JsonIgnore
    @OneToMany(mappedBy = "member")
    private List<Order> orders = new ArrayList<>();



}
