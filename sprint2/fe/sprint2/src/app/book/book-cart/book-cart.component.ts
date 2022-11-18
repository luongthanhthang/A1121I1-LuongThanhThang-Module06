import {Component, OnInit} from '@angular/core';
import {CartService} from '../../service/cart.service';
import {ICart} from '../../model/cart/ICart';
import {ICartBook} from '../../model/cart/ICartBook';
import {TokenStorageService} from '../../service/security/token-storage.service';
import {CustomerService} from '../../service/customer.service';
import {FormControl, FormGroup} from '@angular/forms';
import {element} from 'protractor';

@Component({
  selector: 'app-book-cart',
  templateUrl: './book-cart.component.html',
  styleUrls: ['./book-cart.component.css']
})
export class BookCartComponent implements OnInit {
  // cartList: ICart[] = [];
  cartForm: FormGroup;
  cartBookList: ICartBook[] = [];
  accountId: number;
  checkList: boolean[] = [];
  checkAll = false;
  money = 0.0;
  totalMoney = 0.0;

  constructor(
    private tokenStorageService: TokenStorageService,
    private cartService: CartService,
    private customerService: CustomerService
  ) {
  }

  ngOnInit(): void {
    this.accountId = this.tokenStorageService.getUser().account.accountId;
    this.findAllCartBook();
    this.cartForm = new FormGroup({
      quantity: new FormControl(2)
    });

    this.getTotalMoney();
  }

  findAllCartBook() {
    this.cartService.findAllCartBook(this.accountId).subscribe((data: ICartBook[]) => {
      this.cartBookList = data;
      for (let i = 0; i < data.length; i++) {
        this.checkList.push(false);
      }
    });

  }

  // ====thêm, giảm sản phẩm====
  subBook(cartBook: ICartBook) {
    cartBook.cartId.cartQuantity = cartBook.cartId.cartQuantity - 1;
    this.cartService.updateQuantityCart(cartBook).subscribe(data => {
    }, () => {
    }, () => {
      this.findAllCartBook();
      this.getTotalMoney();
    });
  }

  addBook(cartBook: ICartBook) {
    cartBook.cartId.cartQuantity = cartBook.cartId.cartQuantity + 1;
    this.cartService.updateQuantityCart(cartBook).subscribe(data => {
    }, () => {
    }, () => {
      this.findAllCartBook();
      this.getTotalMoney();
    });
  }

  isAllChecked() {
    if (this.checkAll) {
      this.checkAll = false;
    } else {
      this.checkAll = true;
    }

    if (this.checkAll) {
      this.checkList.forEach((checked, index) => {
        this.checkList[index] = true;
      });
    } else {
      this.checkList.forEach((checked, index) => {
        this.checkList[index] = false;
      });
    }

    this.getTotalMoney();
  }

  isChecked(i: number) {
    if (this.checkList[i]) {
      this.checkList[i] = false;
    } else {
      this.checkList[i] = true;
    }
    this.getTotalMoney();
  }

  getTotalMoney() {
    this.cartService.findAllCartBook(this.accountId).subscribe((data: ICartBook[]) => {
      this.cartBookList = data;
      this.cartBookList.forEach((check, index) => {
        if (this.checkList[index]) {
          this.money += this.cartBookList[index].bookId.bookPrice * this.cartBookList[index].cartId.cartQuantity
            - (this.cartBookList[index].bookId.bookPrice * this.cartBookList[index].cartId.cartQuantity
              * (this.cartBookList[index].bookId.bookPromotionId.promotionPercent / 100));
        }
      });
      this.totalMoney = this.money;
      this.money = 0.0;
    });
  }
}
