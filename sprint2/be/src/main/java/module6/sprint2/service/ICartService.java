package module6.sprint2.service;

import module6.sprint2.entity.cart.Cart;

import java.util.List;

public interface ICartService {
    List<Cart> findAllCart(Long id);

    void updateQuantityCart(Integer cartQuantity, Double cartTotalMoney, Long cartId);

}
