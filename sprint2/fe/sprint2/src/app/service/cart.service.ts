import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {ICart} from '../model/cart/ICart';
import {ICartBook} from '../model/cart/ICartBook';

@Injectable({
  providedIn: 'root'
})
export class CartService {
  readonly URI: string = 'http://localhost:8080/api/cart';

  constructor(
    private httpClient: HttpClient
  ) {
  }

  // findAllCart(): Observable<ICart[]> {
  //   return this.httpClient.get<ICart[]>(this.URI + '/list-cart');
  // }

  findAllCartBook(accountId: number): Observable<ICartBook[]> {
    return this.httpClient.get<ICartBook[]>(this.URI + '/list-cart-book?accountId=' + accountId);
  }

  updateQuantityCart(cartBook: ICartBook): Observable<void> {
    return this.httpClient.put<void>(this.URI + '/update-quantity', cartBook);
  }
}
