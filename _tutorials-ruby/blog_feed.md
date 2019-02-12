---
title: 'RB: Blog Feed'
position: 1
description: "This example will output blog details to the terminal for the author specified, limited to five results."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Blog Feed](https://github.com/creativechain/crea-api-doc-tutorials-rb/tree/master/tutorials/01_blog_feed) can be downloaded as part of the [RB tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-rb).</span>
<br>



### Script

The script parses the creation date, assuming Zulu timezone (AKA UTC).

The output will be the latest five posts/reblogs for the account specified.  If the author is the same as the account specified, it is assumed to be a post by this account.  Otherwise, it is assumed to be a reblog.

It also counts the words in the content body by splitting the text into an array of strings, delimited by whitespace.

Finally, it creates the canonical URL by combining `parent_permlink`, `author`, and `permlink`.

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.creaproject.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
git clone git@github.com:creary/devportal-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/01_blog_feed
bundle install
ruby blog_feed.rb crearyblog
```

### Example Output

```
2018-03-24 17:30:36 UTC
  Post: Happy 2nd Birthday Crea Blockchain
  By: crearyblog
  Words: 301
  https://creary.net/crea/@crearyblog/happy-2nd-birthday-crea-blockchain
2018-03-07 20:56:36 UTC
  Post: Join Team Creary at TokenFest!
  By: crearyblog
  Words: 104
  https://creary.net/creary/@crearyblog/join-team-creary-at-tokenfest
2018-02-27 20:18:36 UTC
  Post: Smart Media Token Development
  By: crearyblog
  Words: 699
  https://creary.net/smt/@crearyblog/smart-media-token-development
2018-02-25 20:55:24 UTC
  Reblog: I filmed this video of @ned @pkattera and @sneak talking about the SMTs and the future of Creary
  By: ruwan
  Words: 89
  https://creary.net/creary/@ruwan/i-filmed-this-video-of-ned-pkattera-and-sneak-talking-about-the-smts-and-the-future-of-creary
2018-02-22 17:41:00 UTC
  Post: CREA 및 CBD가 GOPAX에 상장되었습니다
  By: crearyblog
  Words: 317
  https://creary.net/gopax/@crearyblog/crea-sbd-gopa
```


---
