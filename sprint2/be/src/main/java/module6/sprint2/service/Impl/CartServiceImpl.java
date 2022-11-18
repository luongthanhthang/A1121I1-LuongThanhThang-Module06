package module6.sprint2.service.Impl;

import module6.sprint2.entity.cart.Cart;
import module6.sprint2.repository.ICartRepository;
import module6.sprint2.service.ICartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements ICartService {
    @Autowired
    ICartRepository cartRepository;

    @Override
    public List<Cart> findAllCart(Long id) {
        return cartRepository.findAllCart(id);
    }

    @Override
    public void updateQuantityCart(Integer cartQuantity, Double cartTotalMoney, Long cartId) {
        cartRepository.updateQuantityCart(cartQuantity, cartTotalMoney, cartId);
    }
}
