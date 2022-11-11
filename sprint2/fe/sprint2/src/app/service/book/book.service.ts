import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {IBook} from "../../model/book/IBook";

@Injectable({
  providedIn: 'root'
})
export class BookService {
  readonly URI: string = 'http://localhost:8080/api/book';

  constructor(
    private httpClient: HttpClient
  ) {
  }

  findAllBookIntro(): Observable<IBook[]> {
    return this.httpClient.get<IBook[]>(this.URI + '/book-customer/no-login/book-list-intro');
  }

  findAllBookBestSellerIntro(): Observable<IBook[]> {
    return this.httpClient.get<IBook[]>(this.URI + '/book-customer/no-login/book-list-best-seller-intro');
  }

  findAllBookBestSeller(): Observable<IBook[]> {
    return this.httpClient.get<IBook[]>(this.URI + '/book-customer/no-login/book-list-best-seller');
  }

}
