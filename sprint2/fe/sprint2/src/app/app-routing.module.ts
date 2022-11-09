import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {BookIntroComponent} from "./book/book-intro/book-intro.component";
import {BookListComponent} from "./book/book-list/book-list.component";
import {BookCartComponent} from "./book/book-cart/book-cart.component";
import {BookDetailComponent} from "./book/book-detail/book-detail.component";
import {LoginComponent} from "./security/login/login.component";


const routes: Routes = [
  {path: '', component: BookIntroComponent},
  {path: 'cart', component: BookCartComponent},
  {path: 'book/detail/:id', component: BookDetailComponent},
  {path: 'book/list', component: BookListComponent},
  {path: 'login', component: LoginComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
