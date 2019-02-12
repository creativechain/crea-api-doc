---
title: 'JS: Creaconnect'
position: 2
description: "_Understand the basics of using Creaconnect with your Crea application._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Creaconnect](https://github.com/creativechain/crea-api-doc-tutorials-js/tree/master/tutorials/02_creaconnect) can be downloaded as part of the [JS tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-js).</span>
<br>



In this tutorial we will setup Creaconnect for demo application and step by step show the process of setting up dedicated account for your app to use Creaconnect Dashboard and setup backend of your application to use Creaconnect authorization properly.

## Intro

The application in this tutorial asks the user to grant an access to `demo-app` and get token from Creaconnect. Once permission is granted, `demo-app` can get details of user via an api call that requires access token.
Purpose is to allow any application request permission from user and perform action via access token.

Some other calls that require an access token (or login) are:

*   Vote
*   Comment
*   Post
*   Follow
*   Reblog

Learn more about [Creaconnect operations here](https://github.com/creativechain/creaconnect-sdk)

## Steps

1.  [**Creaconnect Dashboard**](#sc-dashboard) Create account for application and set up dashboard
1.  [**Initialize Creaconnect**](#init-sc) Initialize SDK in your application code
1.  [**Login URL**](#login-url) Form login url for user
1.  [**Request token**](#request-token) Request token with login url
1.  [**Set token**](#set-token) Set or save token for future requests
1.  [**Get user data**](#get-user) Get user details with token
1.  [**Logout**](#logout) Logout user and clear token

#### 1. Creaconnect Dashboard<a name="sc-dashboard"></a>

Creaconnect is unified authentification system built on top of Crea built in collaboration of Busy.org and Creary Inc.
Layer to ensure easy access and setup for all application developers as well as secure way for users to interact with Crea apps.

Setting up Creaconnect in your app is straight-forward process and never been this easy.

Here are the steps that helps you to setup new app:

1a. Visit [Creaconnect Dashboard](https://creaconnect.com/dashboard) and login with your Crea credentials

![creaconnect_login](https://github.com/creativechain/crea-api-doc-tutorials-js/blob/master/tutorials/02_creaconnect/images/creaconnect_login.png?raw=true)

1b. You will see Applications and Developers section, in Developers section click on `My Apps`

![creaconnect_dashboard](https://github.com/creativechain/crea-api-doc-tutorials-js/blob/master/tutorials/02_creaconnect/images/creaconnect_dashboard.png?raw=true)

![creaconnect_new_app](https://github.com/creativechain/crea-api-doc-tutorials-js/blob/master/tutorials/02_creaconnect/images/creaconnect_new_app.png?raw=true)

1c. Create New App using Creaconnect, which will help you create new Crea account for your application. Let's call it `demo-app` for this tutorial purpose.

![creaconnect_account_create](https://github.com/creativechain/crea-api-doc-tutorials-js/blob/master/tutorials/02_creaconnect/images/creaconnect_account_create.png?raw=true)

Account creation fee will be deducted from your balance, make sure you have enough funds to complete account creation.

Next step is to login with account which has enough balance to pay for account creation fee.

![creaconnect_signin](https://github.com/creativechain/crea-api-doc-tutorials-js/blob/master/tutorials/02_creaconnect/images/creaconnect_signin.png?raw=true)

1d. Give your app name, description, icon image link, website (if available) and Redirect URI(s)

![creaconnect_myapps](https://github.com/creativechain/crea-api-doc-tutorials-js/blob/master/tutorials/02_creaconnect/images/creaconnect_myapps.png?raw=true)

Application name and description should give users clear understanding what permissions it requires and what is the purpose of the app.

App Icon field should be publicly accessible and available link to your logo or icon.

Website field is homepage for the application if exist.

Redirect URI(s) will be used within your application to forward user after authentification is successful. You can specify multiple callback URLs with each new line. Callback in Creaconnect SDK should match exactly one of URI(s) specified on this page. Due to security reasons if redirect URI(s) used in SDK is other than you specified, it will not work.
This is typical backend web development, we hope you know how to set up your backend/app to handle callback URLs.

*   Disclaimer: All images/screenshots of user interface may change as Creaconnect evolves

#### 2. Initialize Creaconnect<a name="init-sc"></a>

Once you have setup account for new application, you can setup application with Creaconnect authentification and API processes.
To do that, you will need to install `sc2-sdk` nodejs package with `npm i sc2-sdk`.
Within application you can initialize Creaconnect

> `app` - is account name for application that we have created in Step I.3, `callbackURL` - is Redirect URI that we have defined in Step I.4, `scope` - permissions application is requiring/asking from users

Now that `sc2-sdk` is initialized we can start authentication and perform simple operations with Creaconnect.

#### 3. Login URL<a name="login-url"></a>

> `getLoginURL` function you see on the right side, returns login URL which will redirect user to sign in with Crea connect screen. Successfull login will redirect user to Redirect URI or `callbackURL`. Result of successful login will return `access_token`, `expires_in` and `username` information, which application will start utilizing.

#### 4. Request token<a name="request-token"></a>

> Application can request returned link into popup screen or relevant screen you have developed. Popup screen will ask user to identify themselves with their username and password. Once login is successful, you will have Results

#### 5. Set token<a name="set-token"></a>

> Returned data has `access_token` - which will be used in future api calls, `expires_in` - how long access token is valid in seconds and `username` of logged in user.

> After getting `access_token`, we can set token for future Creaconnect API requests.

#### 6. Get user data<a name="get-user"></a>

> Users info can be checked with `me` which will return object
> `account` - current state of account and its details on Crea blockchain, `name` - username, `scope` - permissions allowed with current login, `user` - username, `user_metadata` - additional information user has setup.

#### 7. Logout<a name="logout"></a>

> In order to logout, you can use `revokeToken` function from sc2-sdk.

**That's all there is to it.**

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/02_creaconnect`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
