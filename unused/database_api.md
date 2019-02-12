---
title: Database API
position: 2
---

Subscription examples

~~~ javascript
crea.api.setSubscribeCallback(callback, clearFilter, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Subscribe Callback"} 

~~~ javascript
crea.api.setPendingTransactionCallback(cb, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Pending Transaction Callback"} 

~~~ javascript
crea.api.setBlockAppliedCallback(cb, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Block Applied Callback"} 

~~~ javascript
crea.api.cancelAllSubscriptions(function(err, result) {
  console.log(err, result);
});
~~~
{: title="Cancel All Subscriptions"}         
