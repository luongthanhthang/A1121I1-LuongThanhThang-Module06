import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HeaderComponent } from './layout/header/header.component';
import { BookListComponent } from './book/book-list/book-list.component';
import { FooterComponent } from './layout/footer/footer.component';
import { BookDetailComponent } from './book/book-detail/book-detail.component';
import { BookIntroComponent } from './book/book-intro/book-intro.component';
import { LoginComponent } from './security/login/login.component';
import { ErrorComponent } from './security/error/error.component';
import { ErrorNotFoundComponent } from './security/error/error-not-found/error-not-found.component';
import { BookCartComponent } from './book/book-cart/book-cart.component';
import {authInterceptorProviders} from "./helpers/auth.interceptor";
import {JWT_OPTIONS, JwtHelperService} from "@auth0/angular-jwt";
import {APP_BASE_HREF} from "@angular/common";

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    BookListComponent,
    FooterComponent,
    BookDetailComponent,
    BookIntroComponent,
    LoginComponent,
    ErrorComponent,
    ErrorNotFoundComponent,
    BookCartComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [ authInterceptorProviders,
    JwtHelperService,
    {provide: JWT_OPTIONS, useValue: JWT_OPTIONS},
    { provide: APP_BASE_HREF, useValue: '/'}
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
