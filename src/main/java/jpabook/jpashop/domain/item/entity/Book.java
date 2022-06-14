package jpabook.jpashop.domain.item.entity;

import jpabook.jpashop.domain.item.entity.Item;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@Getter @Setter
@DiscriminatorValue("B")
public class Book extends Item {

    private String author;
    private String isbn;

}