package jpabook.jpashop.item.entity;

import jpabook.jpashop.catalog.entity.Category;
import jpabook.jpashop.common.exception.NotEnoughStockException;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "item")
@DiscriminatorColumn(name = "dtype")
public abstract class Item {

    @Id
    @GeneratedValue
    @Column(name = "item_id")
    private Long id;

    private String name;

    private int price;

    private int stockQuantity;

    @ManyToMany(mappedBy = "items")
    private List<Category> categories = new ArrayList<>();

    /// 비즈니스 로직

    /**
     * addStock
     *  기존 stockQuantity에 quantity만큼 더합니다.
     * @param quantity
     */
    public void addStock(int quantity) {
        this.stockQuantity+=quantity;
    }

    /**
     * removeStock
     *  기존 stockQuantity에 quantity만큼 뺍니다.
     * @param quantity
     */
    public void removeStock(int quantity) {
        int resultStock = this.stockQuantity - quantity;
        if(resultStock<0){
            throw new NotEnoughStockException("Need More Stock");
        }

        this.stockQuantity =resultStock;
    }

}
