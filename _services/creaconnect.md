---
title: CreaConnect
position: 2
---

**What is CreaConnect?**

The goal of CreaConnect is to provide a safe way of connecting to the blockchain via 3rd party apps without compromising the security of your private keys and passwords. It's a simple identity layer built on top of the blockchain allowing users safe access and developers the freedom of not having to handle the authentication system, i.e. managing users' private keys and encryption. This means that devs won't have to opensource their projects in order to gain user trust. When connecting to apps in this manner, neither CreaConnect nor the authorised app store the private keys as the posting key is incrypted on your cookie.


**How CreaConnect is implemented**

CreaConnect works by granting an access token to the requesting app once the application has been approved.
A full tutorial on how to set up an application, request authorisation and grant access can be found [here]({{ '/tutorials-javascript/creaconnect' | relative_url }}).

**Crea Authorisation and OAuth 2**

The OAuth protocol allows third party apps to grant limited access to an HTTP service, either on behalf of a resource owner or by allowing the app to obtain access on its own behalf. The authorisation is provided without the private key or password of the user being shared with the third party.
Simplified, the process includes the following steps:

1.  The user is presented with an authorisation link that requests a token from the API
2.  The user has to log in to the service to verify their identity whereupon they will be prompted to authorise the application
3.  The user is redirected to the application redirect URI along with the access token

Once the application has an access token, it may use the token to access the user's account via the API, limited to the scope of access, until the token expires or is revoked.
A full breakdown of OAuth2 and how it applies to CreaIt and CreaConnect can be found [here](https://github.com/creativechain/creaconnect/wiki/OAuth-2#code-authorization-flow).

**Useful Links**

*   [CreaConnect Repo](https://github.com/creativechain/creaconnect)
*   [Community Resources]({{ '/resources/#community-crea-connect-libs' | relative_url }})


For additional material you can refer to the original creary [blog](https://creary.net/creaconnect/@busy.org/introducing-creaconnect-by-busy-identity-authentication-authorization-for-crea-blockchain-s-apps) post by [busy.org](https://busy.org/)
