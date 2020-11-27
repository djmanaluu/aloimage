# Aloimage App

## API

For API I used Vapor (a Swift Framework for Web App) and Heroku.<br>
Here's the Repo of the API:

**https://github.com/djmanaluu/aloimage-api**


<img src="images/API%20Repo.png" width="400"> </img>

## Design Patter

I used MVVM + Coordinator

## Unit Testing

There are some Unit-Testing to test all View Model and I used Dependency Injection to test the fetcher to mock the fetch process.

## Login Flow

**1. Login Page** (directory: Alodokter Test App/Login Flow/Login Page)

We can login with this page with 2 parameters (email and password).
If you don't have the account, you should register first in Register Page by click **Register Here** button on this page.

There are some conditions here:
- To activated the login button, we should make sure that the email and password text field is not empty.
- If login is failed, there will be a banner view on the top of the page that will inform user that the email and password are wrong.

<img src="images/Login%20Page.png" width="250">

**2. Register Page** (directory: Alodokter Test App/Login Flow/Register Page)

We can Register for new account here.

**NOTE:**
**- I haven't handled the same email that registered, so there'll be a bug if we add a new account with an email that have been registered.**
**- There is no checker that the text that typed is email because we can use simple username here to help us to make an easier test**
**- There's no email verification and reset password here**

<img src="images/Register%20Page.png" width="250">

## Main Flow

In the Main Flow there's an tabbar Here

**1. Home Page** (directory: Alodokter Test App/Main Flow/Home)

In this page, will be shown all album (each album will be shown by the first image only)<br>
If we click the album, will be directed to **Content Detail Page**

<img src="images/Home%20Page.png" width="250">

**2. Content Detail Page** (directory: Alodokter Test App/Main Flow/Content Detail)

This page will show all image from album that we selected.<br>
There's a pagination.

 <img src="images/Content%20Viewer.png" width="250">

**3. Profile Page** (directory: Alodokter Test App/Main Flow/Profile)

This page to show the user's profile and user can edit the image and other fields.<br>

Conditions:
- For image just saved on local (using UserDefaults), for all text fields will be saved on server.
- Update button will be activated if only all text fields are not empty and there are any changes on all text fields. After upload, the button will be deactivated again.
<img src="images/Profile%20Page.png" width="250">


