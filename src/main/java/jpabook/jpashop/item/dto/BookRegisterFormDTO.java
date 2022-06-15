package jpabook.jpashop.item.dto;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@Setter
public class BookRegisterFormDTO {

    private Long id;

    @NotEmpty
    private String name;

    @NotNull
    private Integer price;

    @NotNull @Range(min=0,max=10000)
    private Integer stockQuantity;

    @NotEmpty
    private String author;
    @NotEmpty
    private String isbn;

}
